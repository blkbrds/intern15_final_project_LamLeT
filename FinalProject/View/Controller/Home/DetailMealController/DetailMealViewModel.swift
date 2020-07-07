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

    // MARK: - Enum
    enum Section: Int {
        case image = 0
        case information
        case video
        case instruction
        case ingrentMeasure
        case linkSource
        case otherFood
    }
    
    // MARK: Properties
    var idMeal: String = ""
    private var sections: [Section] = [.image, .video, .instruction, .ingrentMeasure, .linkSource, .otherFood]
    
    // MARK: - Life Cycle
    init() { }

    init(meal: Meal) {
        self.idMeal = meal.idMeal
    }

    // MARK: - Data Table
    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfRowsInSection(section: Section) -> Int {
        switch section {
        case .image, .information, .video, .instruction, .ingrentMeasure, .linkSource, .otherFood:
            return 1
        }
    }
}
