//
//  DetailMealViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

class DetailMealViewModel {
    var idMeal: String = ""
    var detailMeals: [Meal] = []

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
                for item in detailMeal.categoryMeals {
                    self.detailMeals.append(item)
                }
                completion(true, "Loading Success")
            }
        }
    }

    // MARK: - Data Table
    func numberOfSections() -> Int {
        return 7
    }

    func numberOfRowsInSection(section: Int) -> Int {
        if section == 0 {
            return detailMeals.count
        } else if section == 1 {
            return detailMeals.count
        } else if section == 2 {
            return detailMeals.count
        } else if section == 3 {
            return detailMeals.count
        } else if section == 4 {
            return detailMeals.count
        } else if section == 5 {
            return detailMeals.count
        } else if section == 6 {
            return detailMeals.count
        }
        return 0
    }

    func cellForRowAt(indexPath: IndexPath) -> DetailMealTableViewCellViewModel {
        let item = detailMeals[indexPath.row]
        let model = DetailMealTableViewCellViewModel(meal: item)
        return model
    }
}
