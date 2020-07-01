//
//  OrtherFoodCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 7/1/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

class OrtherFoodCellViewModel {
    var ortherMealName: String = ""
    var urlOrtherMealImage: String = ""

    init() { }
    
    init(meal: Meal) {
        self.ortherMealName = meal.mealName
        self.urlOrtherMealImage = meal.urlMealThumbnail
    }
}
