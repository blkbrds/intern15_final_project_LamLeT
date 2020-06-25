//
//  DetailMealViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

class DetailMealViewModel {
    var idMeal: String = ""

    init() { }
    
    init(meal: Meal) {
        self.idMeal = meal.idMeal
    }
    
    // MARK: - Data Table
    func numberOfSections() -> Int {
        return 7
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return 1
        } else if section == 5 {
            return 1
        } else if section == 6 {
            return 1
        }
        return 0
    }
}
