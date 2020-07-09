//
//  DetailCategoryViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/22/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit
import MVVM


final class DetailCategoryViewModel {

    // MARK: - Properties
    var nameCategory: String = ""
    var mealCategory: [Meal] = []

    // MARK: - Define
    struct Configure {
        static let uiOffSet: UIOffset = UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2)
        static let sizeForCellCollection: CGSize = CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
        static let spaceForCell: UIEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }

    init() { }

    init(nameCategory: String) {
        self.nameCategory = nameCategory
    }

    // MARK: - Get API
    func getAPIListCategory(completion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealForCategory(categoryName: nameCategory) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .failure(let error):
                completion(false, error)
            case .success(let detailCategory):
                for item in detailCategory.meals {
                    self.mealCategory.append(item)
                }
                completion(true, App.String.loadSuccess)
            }
        }
    }

    func pushIdMeal(indexPath: IndexPath) -> DetailMealViewModel {
        let item = mealCategory[indexPath.row]
        let model = DetailMealViewModel(meal: item)
        return model
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
