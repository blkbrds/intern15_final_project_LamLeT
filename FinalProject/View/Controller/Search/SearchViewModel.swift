//
//  SearchViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 7/9/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

final class SearchViewModel {

  

    // MARK: - Properties
    var mealResult: [Meal] = []

    // MARK: Get API
    func searchAPIFirstLetter(firstLetter: String, completion: @escaping (Bool, String) -> Void) {
        Networking.shared().searchMealFirstLetter(firstLetter: firstLetter) { (mealResult) in
            switch mealResult {
            case .failure(let error):
                completion(false, error)
            case .success(let result):
                for item in result.meals {
                    self.mealResult.append(item)
                }
                completion(true, App.String.loadSuccess)
            }
        }
    }

    func searchAPIByName(nameMeal: String?, completion: @escaping (Bool, String) -> Void) {
        guard let name = nameMeal,
            !name.isEmpty else {
                self.mealResult = []
                completion(true, App.String.loadSuccess)
                return
        }
        Networking.shared().searchMealByName(name: name) { (mealResult) in
            switch mealResult {
            case .failure(let error):
                self.mealResult = []
                completion(false, error)
            case .success(let result):
                self.mealResult = result.meals
                completion(true, App.String.loadSuccess)
            }
        }
    }

    // MARK: - TableView Data
    func numberOfRowsInSection() -> Int {
        return mealResult.count
    }

    func cellForRowAt(indexPath: IndexPath) -> SearchTableCellViewModel {
        let item = mealResult[indexPath.row]
        let viewModel = SearchTableCellViewModel(meal: item)
        return viewModel
    }

    func heightForRowAt() -> CGFloat {
        return 250
    }

    func pushToView(indexPath: IndexPath) -> DetailMealViewModel {
        let item = mealResult[indexPath.row]
        let viewModel = DetailMealViewModel(meal: item)
        return viewModel
    }
}
