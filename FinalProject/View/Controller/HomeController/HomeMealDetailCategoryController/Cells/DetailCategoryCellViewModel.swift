//
//  DetailCategoryCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/22/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

class DetailCategoryCellViewModel {
    var nameMeal: String
    var thumbnailMeal: UIImage?
    
    init(meal: Meal) {
        self.nameMeal = meal.mealName
        self.thumbnailMeal = meal.thumbnail
    }
}
