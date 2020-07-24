//
//  DetailMealTableViewCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

final class DetailMealTableViewCellViewModel {

    // MARK: - Properties
    var meal: Meal

    init(meal: Meal) {
        self.meal = meal
    }

    // MARK: - Functions
    func getLinkVideo() -> String {
        if let url = meal.urlVideoMeal, let range = url.range(of: "=") {
            return String(url[range.upperBound...])
        } else {
            return "No Has Video Tutorial"
        }
    }
}
