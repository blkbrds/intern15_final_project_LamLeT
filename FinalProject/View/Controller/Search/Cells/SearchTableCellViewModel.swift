//
//  SearchTableCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 7/9/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

class SearchTableCellViewModel {
    var mealName: String
    var urlThumbnail: String
    
    init(meal: Meal) {
        self.mealName = meal.mealName
        self.urlThumbnail = meal.urlMealThumbnail
    }
}
