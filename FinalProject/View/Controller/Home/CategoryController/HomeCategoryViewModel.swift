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

    // MARK: - Data Collection
    func numberOfItemsInSection() -> Int {
        return categoryMeals.count
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
}
