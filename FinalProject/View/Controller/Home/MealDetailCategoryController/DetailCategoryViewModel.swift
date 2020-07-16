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

class DetailCategoryViewModel {

    // MARK: - Properties
    var nameCategory: String = ""
    var mealCategory: [Meal] = []

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
