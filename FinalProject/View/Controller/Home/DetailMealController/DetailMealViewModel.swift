//
//  DetailMealViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import RealmSwift

class DetailMealViewModel {

    // MARK: - Define
    struct Configure {
        static let spaceForSection: CGFloat = 10
        static let iconAddFavorites: String = "heart"
        static let iconRemoveFavorites: String = "heart.fill"
        static let haveItem: String = "Item is Favorites"
        static let notHaveItem: String = "Item not is Favorites"
        static let addObjectSuccess: String = "Success To Add Object"
        static let addObjectFailed: String = "Failed To Add Object"
        static let deleteObjectSuccess: String = "Success To Delete Object"
        static let deleteObjectFailed: String = "Failed To Delete Object"
    }

    // MARK: - Properties
    var idMeal: String = ""
    var detailMeals: [Meal] = []
    var randomMeals: [Meal] = []
    var headerTitler: [String] = ["Image", "Infomation", "Video", "Instruction", "Ingredient And Measure", "Link Source", "Orther Food"]
    var ingredientMeasure: [String: String] = [:]

    //MARK: Realm
    var nameMeal: String = ""
    var imageMealURL: String = ""
    var isFavorites: Bool = false

    init() { }

    init(meal: Meal) {
        self.idMeal = meal.idMeal

        //MARK: Realm
        self.nameMeal = meal.mealName
        self.imageMealURL = meal.urlMealThumbnail
        self.ingredientMeasure = meal.ingredientMeasure
    }

    // MARK: Get API
    func getAPIDetailMeal(completion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealDetail(idMeal: idMeal) { (result) in
            switch result {
            case .failure(let error):
                completion(false, error)
            case .success(let detailMeal):
                for item in detailMeal.meals {
                    self.detailMeals.append(item)
                }
                completion(true, App.String.loadSuccess)
            }
        }
    }

    func getAPIRandomMeal(completion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealRandom { (result) in
            switch result {
            case .failure(let error):
                completion(false, error)
            case .success(let randomMeal):
                for item in randomMeal.meals {
                    self.randomMeals.append(item)
                }
                completion(true, App.String.loadSuccess)
            }
        }
    }


    // MARK: - Data Table
    func numberOfSections() -> Int {
        return 7
    }

    func numberOfRowsInSection(section: Int) -> Int {
        if section == 0 {
            return detailMeals.count
        } else if section == 1 {
            return detailMeals.count
        } else if section == 2 {
            return detailMeals.count
        } else if section == 3 {
            return detailMeals.count
        } else if section == 4 {
            return detailMeals.count
        } else if section == 5 {
            return detailMeals.count
        } else if section == 6 {
            return randomMeals.count
        }
        return 0
    }

    func cellForRowAt(indexPath: IndexPath) -> DetailMealTableViewCellViewModel {
        let item = detailMeals[indexPath.row]
        let model = DetailMealTableViewCellViewModel(meal: item)
        return model
    }

    func cellForRowRandomMeal(indexPath: IndexPath) -> OtherFoodCellViewModel {
        let item = randomMeals[indexPath.row]
        let model = OtherFoodCellViewModel(meal: item)
        return model
    }

    func pushIdMeal(indexPath: IndexPath) -> DetailMealViewModel {
        let item = randomMeals[indexPath.row]
        let model = DetailMealViewModel(meal: item)
        return model
    }

    //MARK: Realm
    func checkFavorites(checkCompletion: @escaping (Bool, String) -> Void) {
        do {
            let realm = try Realm()
            let meal = realm.objects(MealRealm.self).filter("idMeal = '\(idMeal)' AND isFavorites = true ")
            if meal.count == 0 {
                isFavorites = false
                checkCompletion(true, App.String.notHaveItem)
            } else {
                isFavorites = true
                checkCompletion(false, App.String.haveItem)
            }
        } catch { }
    }

    func addFavorites(addCompletion: @escaping (Bool, String) -> Void) {
        do {
            let realm = try Realm()

            let meal = MealRealm()
            meal.idMeal = idMeal
            meal.nameMeal = nameMeal
            meal.imageURLMeal = imageMealURL
            meal.isFavorites = true
            try realm.write {
                realm.add(meal)
                isFavorites = true
                addCompletion(true, App.String.addObjectSuccess)
            }
        } catch {
            addCompletion(false, App.String.addObjectFailed)
        }
    }

    func deleteFavorites(deleteCompletion: @escaping (Bool, String) -> Void) {
        do {
            let realm = try Realm()

            let meal = realm.objects(MealRealm.self).filter("idMeal = '\(idMeal)'")

            try realm.write {
                realm.delete(meal)
                isFavorites = false
                deleteCompletion(true, App.String.deleteObjectSuccess)
            }
        } catch {
            deleteCompletion(false, App.String.deleteObjectFailed)
        }
    }
}
