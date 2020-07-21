//
//  RandomMealViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 7/15/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

class RandomViewModel {
    var nameMeal: String
    var urlThumbnail: String

    init(meal: Meal) {
        self.nameMeal = meal.mealName
        self.urlThumbnail = meal.urlMealThumbnail
    }
}
