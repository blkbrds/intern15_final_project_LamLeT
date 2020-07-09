//
//  FavoritesTableViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 7/4/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

class FavoritesTableViewModel {
    var nameMeal: String
    var urlImageMeal: String
    
    init(meal: MealRealm) {
        self.nameMeal = meal.nameMeal
        self.urlImageMeal = meal.imageURLMeal
    }
}
