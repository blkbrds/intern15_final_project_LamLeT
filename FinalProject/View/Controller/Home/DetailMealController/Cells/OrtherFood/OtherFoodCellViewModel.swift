//
//  OrtherFoodCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 7/1/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

class OtherFoodCellViewModel {
    
    // MARK: - Define
    struct Configure {
        static let cornerRadius: CGFloat = 10
    }

    // MARK: - Properties
    var otherMealName: String = ""
    var urlOtherMealImage: String = ""

    init() { }

    init(meal: Meal) {
        self.otherMealName = meal.mealName
        self.urlOtherMealImage = meal.urlMealThumbnail
    }
}
