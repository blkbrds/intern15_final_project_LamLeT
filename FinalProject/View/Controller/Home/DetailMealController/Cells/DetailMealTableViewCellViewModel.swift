//
//  DetailMealTableViewCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

final class DetailMealTableViewCellViewModel {

    // MARK: - Properties
    var meal: Meal
    var inforMeal: [String: String] = [:]
    var name: String = ""
    var value: String = ""

    init(meal: Meal, indexPath: IndexPath) {
        self.meal = meal
        inforMeal["Name"] = meal.mealName
        inforMeal["Area"] = meal.area
        inforMeal["Category"] = meal.category
        inforMeal["Tags"] = meal.tags
        
        let names = Array(inforMeal.keys)
        self.name = names[indexPath.row]
        self.value = inforMeal[name] ?? ""
    }

//     MARK: - Functions
//    func inforCellViewModel(at indexPath: IndexPath) -> InforCellViewModel {
//        let names = Array(inforMeal.keys)
//        let name = names[indexPath.row]
//        let value = inforMeal[name] ?? ""
//        let inforCellViewModel = InforCellViewModel(name: name, value: value)
//        return inforCellViewModel
//    }

    func getLinkVideo() -> String {
        if let url = meal.urlVideoMeal, let range = url.range(of: "=") {
            return String(url[range.upperBound...])
        } else {
            return App.String.alertVideo
        }
    }
}
