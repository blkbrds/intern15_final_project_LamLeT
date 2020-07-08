//
//  DetailMealTableViewCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

class DetailMealTableViewCellViewModel {
    
    // MARK: - Define
    struct Configure {
        static let urlVideo = "https://www.youtube.com/embed/"
    }
    
    var meal: Meal

    init(meal: Meal) {
        self.meal = meal
    }
}
