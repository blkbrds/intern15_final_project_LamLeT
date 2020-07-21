//
//  HomeListCategoryViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/22/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

class HomeCategoryViewModel {

    // MARK: - Properties
    var categoryMeals: [CategoryMeal] = []
    var randomeMeals: [Meal] = []

    // MARK: - Public Function
    func getAPIListCategory(listCategoryCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getCategory { [weak self] (mealResult) in
            guard let self = self else {
                return
            }
            switch mealResult {
            case .failure(let error):
                listCategoryCompletion(false, error)
            case .success(let result):
                for item in result.categories {
                    self.categoryMeals.append(item)
                }
                listCategoryCompletion(true, "Get List Category Success")
            }
        }
    }

    func getAPIRandomMeal(completion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealRandom { [weak self] (mealResult) in
            guard let self = self else { return }
            switch mealResult {
            case .failure(let error):
                completion(false, error)
            case .success(let result):
                for item in result.meals {
                    self.randomeMeals = []
                    self.randomeMeals.append(item)
                }
                completion(true, "Load API Random Meal Success")
            }
        }
    }

    // MARK: - Data Collection
    func numberOfSection() -> Int {
        return 2
    }

    func numberOfItemsInSection(section: Int) -> Int {
        if section == 0 {
            return randomeMeals.count
        } else if section == 1 {
            return categoryMeals.count
        }
        return 0
    }

    func getListCategory(indexPath: IndexPath) -> HomeCellCategoryViewModel {
        let item = categoryMeals[indexPath.row]
        let categoryModel = HomeCellCategoryViewModel(categoryMeal: item)
        return categoryModel
    }

    func getNameCategory(indexPath: IndexPath) -> DetailCategoryViewModel {
        let item = categoryMeals[indexPath.row]
        let detailCategoryModel = DetailCategoryViewModel(nameCategory: item.strCategory)
        return detailCategoryModel
    }

    func getRandomMeal(indexPath: IndexPath) -> RandomViewModel {
        let item = randomeMeals[indexPath.row]
        let viewModel = RandomViewModel(meal: item)
        return viewModel
    }

    func pushIdMeal(indexPath: IndexPath) -> DetailMealViewModel {
        let item = randomeMeals[indexPath.row]
        let model = DetailMealViewModel(meal: item)
        return model
    }
}
