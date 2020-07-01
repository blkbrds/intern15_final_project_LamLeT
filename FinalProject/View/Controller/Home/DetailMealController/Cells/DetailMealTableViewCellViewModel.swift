//
//  DetailMealTableViewCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

class DetailMealTableViewCellViewModel {
    var mealName: String = ""
    var category: String = ""
    var area: String = ""
    var instructions: String = ""
    var urlMealThumbnail: String = ""
    var tags: String = ""
    var urlVideoMeal: String = ""
    var ingredient: String = ""
    var measure: String = ""
    var sourceLink: String = ""
    init() { }

    init(meal: Meal) {
        self.urlMealThumbnail = meal.urlMealThumbnail
        self.mealName = meal.mealName
        self.category = meal.category
        self.area = meal.area
        self.tags = meal.tags
        self.urlVideoMeal = meal.urlVideoMeal
        self.instructions = meal.instructions
        self.ingredient = meal.ingredient
        self.measure = meal.measure
        self.sourceLink = meal.sourceLink
    }
}
