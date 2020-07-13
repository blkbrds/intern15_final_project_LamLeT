//
//  DetailMealAreaViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/24/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

class DetailMealCountryViewModel {

    // MARK: - Define
    struct Configure {
        static let title: String = "Area Meal"
        static let nameIconTable: String = "icon_tableView"
        static let nameIconCollection: String = "icon_collectionView"
        static let uiOffSet: UIOffset = UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2)
        static let sizeForCollection: CGSize = CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
        static let spaceForCell: UIEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }

    // MARK: - Properties
    var mealAreas: [Meal] = []
    var nameArea: String = ""

    init() { }

    init(nameArea: String) {
        self.nameArea = nameArea
    }

    // MARK: Get API
    func getAPIListArea(detailAreaCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealDetailArea(areaName: nameArea) { (detailAreaResult) in
            switch detailAreaResult {
            case .failure(let error):
                detailAreaCompletion(false, error)
            case .success(let detailMealArea):
                for item in detailMealArea.meals {
                    self.mealAreas.append(item)
                }
                detailAreaCompletion(true, App.String.loadSuccess)
            }
        }
    }

    // MARK: - TableView Data
    func numberOfRowsInSection() -> Int {
        return mealAreas.count
    }

    func cellForRowAt(indexPath: IndexPath) -> DetailCategoryCellViewModel {
        let item = mealAreas[indexPath.row]
        let model = DetailCategoryCellViewModel(meal: item)
        return model
    }

    func pushIdMeal(indexPath: IndexPath) -> DetailMealViewModel {
        let item = mealAreas[indexPath.row]
        let idMeal = item.idMeal
        let model = DetailMealViewModel(idMeal: idMeal)
        return model
    }

    func heightForRowAt() -> CGFloat {
        return 250
    }
}
