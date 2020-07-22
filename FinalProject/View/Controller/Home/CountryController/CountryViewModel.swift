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

    struct Configure {
        static let uiOffSet: UIOffset = UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2)
        static let sizeForCollection: CGSize = CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
        static let spaceForCell: UIEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }

    // MARK: - Properties
    var areas: [Meal] = []

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
        let urlFlag = ItemArray.flag[indexPath.row]
        let model = CountryCellViewModel(meal: item, urlFlagCountry: urlFlag)
        return model
    }

    func getNameArea(indexPath: IndexPath) -> DetailMealCountryViewModel {
        let item = areas[indexPath.row]
        let model = DetailMealCountryViewModel(nameArea: item.area)
        return model
    }
}

