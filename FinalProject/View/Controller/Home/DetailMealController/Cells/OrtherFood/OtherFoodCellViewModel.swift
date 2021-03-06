//
//  OrtherFoodCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 7/1/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

final class OtherFoodCellViewModel {
    var idMeal: String = ""
    var otherMealName: String = ""
    var urlOtherMealImage: String = ""
    var isFavorites: Bool = false

    init() { }

    init(meal: Meal) {
        self.idMeal = meal.idMeal
        self.otherMealName = meal.mealName
        self.urlOtherMealImage = meal.urlMealThumbnail
    }
}
