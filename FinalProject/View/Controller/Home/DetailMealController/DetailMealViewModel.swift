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
    }

    // MARK: - Properties
    var idMeal: String = ""
    var detailMeals: [Meal] = []
    var randomMeals: [Meal] = []
    var headerTitler: [String] = ["Image", "Infomation", "Video", "Instruction", "Ingredient And Measure", "Link Source", "Orther Food"]

    //MARK: Realm
    var nameMeal: String = ""
    var imageMealURL: String = ""
    var isFavoties: Bool = false

    init() { }

    init(meal: Meal) {
        self.idMeal = meal.idMeal

        //MARK: Realm
        self.nameMeal = meal.mealName
        self.imageMealURL = meal.urlMealThumbnail
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
                completion(true, "Loading Success")
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
                completion(true, "Loading Success")
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

    //MARK: Realm
    func checkFavorites(checkCompletion: @escaping (Bool, String) -> Void) {
        do {
            let realm = try Realm()
            let meal = realm.objects(MealRealm.self).filter("idMeal = '\(idMeal)' AND isFavoties = true ")
            if meal.count == 0 {
                isFavoties = false
                checkCompletion(true, "Item not is Favorites")
            } else {
                isFavoties = true
                checkCompletion(false, "Item is Favorites")
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
            meal.isFavoties = true
            try realm.write {
                realm.add(meal)
                isFavoties = true
                addCompletion(true, "Success To Add Object")
            }
        } catch {
            addCompletion(false, "Failed To Add Object")
        }
    }

    func deleteFavorites(deleteCompletion: @escaping (Bool, String) -> Void) {
        do {
            let realm = try Realm()

            let meal = realm.objects(MealRealm.self).filter("idMeal = '\(idMeal)'")

            try realm.write {
                realm.delete(meal)
                isFavoties = false
                deleteCompletion(true, "Success To Delete Object")
            }
        } catch {
            deleteCompletion(false, "Failed To Delete Object")
        }
    }
}
