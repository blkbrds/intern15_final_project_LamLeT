//
//  DetailMealViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

class DetailMealViewModel {

    // MARK: - Properties
    enum Section: Int {
        case section0 = 0
        case section1 = 1
        case section2 = 2
        case section3 = 3
        case section4 = 4
        case section5 = 5
        case section6 = 6
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
        case .section0:
            return 1
        case .section1:
            return 1
        case .section2:
            return 1
        case .section3:
            return 1
        case .section4:
            return 1
        case .section5:
            return 1
        case .section6:
            return 1
        }
    }
}
