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
        Networking.shared().getCategory { (mealResult) in
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

    func downloadImage(at indexPath: IndexPath, completion: @escaping (IndexPath, UIImage?) -> Void) {
        let item = categoryMeals[indexPath.row]
        if item.thumbnail == nil {
            Downloader.shared().downloadImage(urlString: item.strCategoryThumb) { (image) in
                if let image = image {
                    item.thumbnail = image
                    completion(indexPath, image)
                } else {
                    completion(indexPath, nil)
                }
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
