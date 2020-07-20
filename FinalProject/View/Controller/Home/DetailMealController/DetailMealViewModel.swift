//
//  DetailMealViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit




final class DetailMealViewModel {

    // MARK: Properties
    var sections: [Section] = [.image, .information, .video, .instruction, .ingrentMeasure, .linkSource, .otherFood]
    var idMeal: String = ""
    var detailMeals: [Meal] = []
    var randomMeals: [Meal] = []
    var headerTitler: [String] = ["Image", "Infomation", "Video", "Instruction", "Ingredient And Measure", "Link Source", "Orther Food"]

    //MARK: Realm
    var nameMeal: String = ""
    var imageMealURL: String = ""
    var isFavorites: Bool = false

        // MARK: - Life Cycle
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
                completion(true, App.String.loadSuccess)
            }
        }
    }

    // MARK: - Enum
    enum Section: Int {
        case image = 0
        case information
        case video
        case instruction
        case ingrentMeasure
        case linkSource
        case otherFood
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
        return sections.count
    }

    func numberOfRowsInSection(section: Section) -> Int {
        switch section {
        case .image, .information, .video, .instruction, .ingrentMeasure, .linkSource:
            return detailMeals.count
        case .otherFood:
            return randomMeals.count
        }
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
