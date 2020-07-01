//
//  DetailMealViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

class DetailMealViewModel {

    // MARK: - Properties
    var idMeal: String = ""
    var detailMeals: [Meal] = []
    var randomMeals: [Meal] = []
    var headerTitler: [String] = ["Image", "Infomation", "Video", "Instruction", "Ingredient And Measure", "Link Source", "Orther Food"]

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
                for item in detailMeal.meals {
                    self.detailMeals.append(item)
                }
                completion(true, "Loading Success")
            }
        }
    }

    func getAPIRandomMeal(completion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealRandom { (result) in
            switch result {
            case .failure(let error):
                completion(false, error)
            case .success(let randomMeal):
                for item in randomMeal.meals {
                    self.randomMeals.append(item)
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
            return randomMeals.count
        }
        return 0
    }

    func cellForRowAt(indexPath: IndexPath) -> DetailMealTableViewCellViewModel {
        let item = detailMeals[indexPath.row]
        let model = DetailMealTableViewCellViewModel(meal: item)
        return model
    }

    func cellForRowRandomMeal(indexPath: IndexPath) -> OtherFoodCellViewModel {
        let item = randomMeals[indexPath.row]
        let model = OtherFoodCellViewModel(meal: item)
        return model
    }
}
