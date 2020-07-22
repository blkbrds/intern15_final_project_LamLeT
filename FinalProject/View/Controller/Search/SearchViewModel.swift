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

    // MARK: - Define
    struct Configure {
        static let title: String = "Search Meal"
        static let uiOffSet: UIOffset = UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2)
        static let sizeForCellCollection: CGSize = CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
        static let spaceForCell: UIEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }

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
}
