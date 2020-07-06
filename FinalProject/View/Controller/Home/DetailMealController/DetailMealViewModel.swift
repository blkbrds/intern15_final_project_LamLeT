//
//  DetailMealViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

class DetailMealViewModel {

    // MARK: - Properties
    enum Section: Int {
        case image = 0
        case information = 1
        case video = 2
        case instruction = 3
        case ingrentMeasure = 4
        case linkSource = 5
        case otherFood = 6
    }

    var idMeal: String = ""

    init() { }

    init(meal: Meal) {
        self.idMeal = meal.idMeal
    }

// MARK: - Data Table
    func numberOfSections() -> Int {
        return 7
    }

    func numberOfRowsInSection(section: Section) -> Int {
        switch section {
        case .image:
            return 1
        case .information:
            return 1
        case .video:
            return 1
        case .instruction:
            return 1
        case .ingrentMeasure:
            return 1
        case .linkSource:
            return 1
        case .otherFood:
            return 1
        }
    }
}
