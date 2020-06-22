//
//  DetailCategoryViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/22/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

class DetailCategoryViewModel {
    var nameCategory: String

    var mealCategory: [Meal] = []

    init(nameCategory: String) {
        self.nameCategory = nameCategory
    }

    // MARK: - Get API
    func getAPIListCategory(detailCategoryCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealForCategory(categoryName: nameCategory) { (detailCategoryResult) in
            switch detailCategoryResult {
            case .failure(let error):
                detailCategoryCompletion(false, error)
            case .success(let detailCategory):
                for item in detailCategory.categoryMeals {
                    self.mealCategory.append(item)
                }
                detailCategoryCompletion(true, "")
            }
        }
    }

    // MARK: - Download Image
    func downloadImage(at indexPath: IndexPath, completion: @escaping (IndexPath, UIImage?) -> Void) {
        let item = mealCategory[indexPath.row]
        if item.thumbnail == nil {
            Downloader.shared().downloadImage(urlString: item.urlMealThumbnail) { (image) in
                if let image = image {
                    item.thumbnail = image
                    completion(indexPath, image)
                } else {
                    completion(indexPath, nil)
                }
            }
        }
    }

    // MARK: - TableView Data
    func numberOfRowsInSection() -> Int {
        return mealCategory.count
    }

    func cellForRowAt(indexPath: IndexPath) -> DetailCategoryCellViewModel {
        let item = mealCategory[indexPath.row]
        let model = DetailCategoryCellViewModel(meal: item)
        return model
    }
}
