//
//  DetailMealViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

final class DetailMealViewModel {
    
    // MARK: Properties
    var sections: [Section] = [.image, .video, .instruction, .ingrentMeasure, .linkSource, .otherFood]
    var idMeal: String = ""
    var detailMeals: [Meal] = []

    // MARK: - Life Cycle
    init() { }

    init(idMeal: String) {
        self.idMeal = idMeal
    }

    // MARK: Get API
    func getAPIDetailMeal(completion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealDetail(idMeal: idMeal) { (result) in
            switch result {
            case .failure(let error):
                completion(false, error)
            case .success(let detailMeal):
                for item in detailMeal.meals {
                    self.detailMeals.append(item)
                }
                completion(true, "Loading Success")
            }
        }
    }
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

    // MARK: - Data Table
    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfRowsInSection(section: Section) -> Int {
        switch section {
        case .image, .information, .video, .instruction, .ingrentMeasure, .linkSource, .otherFood:
            return detailMeals.count
        }
    }

    func cellForRowAt(indexPath: IndexPath) -> DetailMealTableViewCellViewModel {
        let item = detailMeals[indexPath.row]
        let model = DetailMealTableViewCellViewModel(meal: item)
        return model
    }
}
