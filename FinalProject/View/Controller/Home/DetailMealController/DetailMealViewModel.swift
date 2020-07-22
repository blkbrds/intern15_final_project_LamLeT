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
    var otherFood: [Meal] = []

    var headerTitler: [String] = ["Image", "Infomation", "Video", "Instruction", "Ingredient And Measure", "More Info", "Orther Food"]
    var meal: Meal?
    var ingredient: [String] = []
    var measure: [String] = []
    var infor: [String] = ["Name", "Area", "Category", "Tags"]
    var information: [String] = []
    var category: String = ""

    //MARK: Realm
    var nameMeal: String = ""
    var imageMealURL: String = ""
    var isFavorites: Bool = false

    // MARK: - Life Cycle
    init() { }

    init(idMeal: String, nameMeal: String) {
        self.idMeal = idMeal
        self.nameMeal = nameMeal
    }

    init(meal: Meal) {
        self.idMeal = meal.idMeal

        //MARK: Realm
        self.nameMeal = meal.mealName
        self.imageMealURL = meal.urlMealThumbnail
    }

    func getAPIDetailMeal(completion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealDetail(idMeal: idMeal) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                completion(false, error)
            case .success(let detailMeal):
                this.meal = detailMeal.meal
                if let meal = this.meal {
                    this.detailMeals.append(meal)
                    this.information.append(contentsOf: [meal.mealName, meal.area, meal.category, meal.tags])
                    this.ingredient = meal.ingredientArray
                    this.measure = meal.measureArray
                    this.category = meal.category
                    completion(true, App.String.loadSuccess)
                }
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
        Networking.shared().getMealForCategory(categoryName: category) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                completion(false, error)
            case .success(let randomMeal):
                for item in randomMeal.meals {
                    this.otherFood.append(item)
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
        case .image, .video, .instruction, .linkSource:
            return detailMeals.count
        case .information:
            return information.count
        case .ingrentMeasure:
            return ingredient.count
        case .otherFood:
            return otherFood.count
        }
    }

    func cellForRowAtIngredientMeasure(indexPath: IndexPath) -> InforCellViewModel {
        let name = ingredient[indexPath.row]
        let value = measure[indexPath.row]
        let viewModel = InforCellViewModel(name: name, value: value)
        return viewModel
    }

    func cellForRowAtInformation(indexPath: IndexPath) -> InforCellViewModel {
        let value = information[indexPath.row]
        let name = infor[indexPath.row]
        let viewModel = InforCellViewModel(name: name, value: value)
        return viewModel
    }

    func cellForRowAt(indexPath: IndexPath) -> DetailMealTableViewCellViewModel {
        let item = detailMeals[indexPath.row]
        let model = DetailMealTableViewCellViewModel(meal: item)
        return model
    }

    func cellForRowRandomMeal(indexPath: IndexPath) -> OtherFoodCellViewModel {
        let item = otherFood[indexPath.row]
        let model = OtherFoodCellViewModel(meal: item)
        return model
    }

    func pushIdMeal(indexPath: IndexPath) -> DetailMealViewModel {
        let item = otherFood[indexPath.row]
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
