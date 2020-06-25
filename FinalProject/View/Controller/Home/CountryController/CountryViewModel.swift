//
//  CountryViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/23/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import MVVM

final class CountryViewModel {

    // MARK: - Properties
    var areas: [Meal] = []

    // MARK: - Public Function
    func getAPIListArea(listAreaCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getArea { (areaResult) in
            switch areaResult {
            case .failure(let error):
                listAreaCompletion(false, error)
            case .success(let result):
                for item in result.categoryMeals {
                    self.areas.append(item)
                }
                listAreaCompletion(true, "Get List Area Success")
            }
        }
    }

    // MARK: - Data Collection
    func numberOfItemsInSection() -> Int {
        return areas.count
    }

    func getListArea(indexPath: IndexPath) -> CountryCellViewModel {
        let item = areas[indexPath.row]
        let urlFlag = Arr.flag[indexPath.row]
        let model = CountryCellViewModel(meal: item, urlFlagCountry: urlFlag)
        return model
    }
}

