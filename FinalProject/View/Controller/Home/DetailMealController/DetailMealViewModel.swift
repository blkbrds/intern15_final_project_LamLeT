//
//  DetailMealViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit


final class DetailMealViewModel {

    // MARK: Properties
    var sections: [Section] = [.image, .information, .video, .instruction, .ingrentMeasure, .linkSource, .otherFood]
    var idMeal: String = ""
    var detailMeals: [Meal] = []
    var otherFood: [Meal] = []
    var headerTitler: [String] = ["Image", "Infomation", "Video", "Instruction", "Ingredient And Measure", "Link Source", "Orther Food"]
    var meal: Meal?
    var ingredient: [String] = []
    var measure: [String] = []
    var infor: [String] = ["Name", "Area", "Category", "Tags"]
    var information: [String] = []
    var category: String = ""

    // MARK: - Life Cycle
    init() { }

    init(idMeal: String) {
        self.idMeal = idMeal
    }

    // MARK: Get API
    func getAPIDetailMeal(completion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealDetail(idMeal: idMeal) { (result) in
            switch result {
            case .failure(let error):
                completion(false, error)
            case .success(let detailMeal):
                self.meal = detailMeal.meal
                guard let meal = self.meal else { return }
                self.detailMeals.append(meal)
                self.information.append(contentsOf: [meal.mealName, meal.area, meal.category, meal.tags])
                self.ingredient = meal.ingredientArray
                self.measure = meal.measureArray
                self.category = meal.category
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
        print(self.category)
        Networking.shared().getMealRandom { (result) in
            switch result {
            case .failure(let error):
                completion(false, error)
            case .success(let randomMeal):
                for item in randomMeal.meals {
                    self.otherFood.append(item)
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

    func cellForRowAt(indexPath: IndexPath) -> DetailMealTableViewCellViewModel {
        let item = detailMeals[indexPath.row]
        let model = DetailMealTableViewCellViewModel(meal: item)
        return model
    }

    func cellForRowAtInformation(indexPath: IndexPath) -> InforCellViewModel {
        let value = information[indexPath.row]
        let name = infor[indexPath.row]
        let viewModel = InforCellViewModel(name: name, value: value)
        return viewModel
    }

    func cellForRowAtIngredientMeasure(indexPath: IndexPath) -> InforCellViewModel {
        let name = ingredient[indexPath.row]
        let value = measure[indexPath.row]
        let viewModel = InforCellViewModel(name: name, value: value)
        return viewModel
    }

    func cellForRowRandomMeal(indexPath: IndexPath) -> OtherFoodCellViewModel {
        let item = otherFood[indexPath.row]
        let model = OtherFoodCellViewModel(meal: item)
        return model
    }
}
