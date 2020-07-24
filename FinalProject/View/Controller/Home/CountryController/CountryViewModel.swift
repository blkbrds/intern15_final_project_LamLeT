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
    var randomeMeals: [Meal] = []

    // MARK: - Public Function
    func getAPIListArea(listAreaCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getArea { [weak self] (areaResult) in
            guard let this = self else { return }
            switch areaResult {
            case .failure(let error):
                listAreaCompletion(false, error)
            case .success(let result):
                for item in result.meals {
                    this.areas.append(item)
                }
                listAreaCompletion(true, App.String.loadSuccess)
            }
        }
    }

    func getAPIRandomMeal(completion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealRandom { [weak self] (mealResult) in
            guard let this = self else { return }
            switch mealResult {
            case .failure(let error):
                completion(false, error)
            case .success(let result):
                for item in result.meals {
                    this.randomeMeals = []
                    this.randomeMeals.append(item)
                }
                completion(true, App.String.loadSuccess)
            }
        }
    }

    // MARK: - Data Collection
    func numberOfSection() -> Int {
        return 2
    }

    func numberOfItemsInSection(section: Int) -> Int {
        if section == 0 {
            return randomeMeals.count
        } else if section == 1 {
            return areas.count
        }
        return 0
    }

    func getListArea(indexPath: IndexPath) -> CountryCellViewModel {
        let item = areas[indexPath.row]
        let urlFlag = ItemArray.flag[indexPath.row]
        let model = CountryCellViewModel(meal: item, urlFlagCountry: urlFlag)
        return model
    }

    func getNameArea(indexPath: IndexPath) -> DetailMealCountryViewModel {
        let item = areas[indexPath.row]
        let model = DetailMealCountryViewModel(nameArea: item.area)
        return model
    }

    func getRandomMeal(indexPath: IndexPath) -> RandomMealCountryViewModel {
        let item = randomeMeals[indexPath.row]
        let viewModel = RandomMealCountryViewModel(meal: item)
        return viewModel
    }

    func pushIdMeal(indexPath: IndexPath) -> DetailMealViewModel {
        let item = randomeMeals[indexPath.row]
        let model = DetailMealViewModel(meal: item)
        return model
    }
}

