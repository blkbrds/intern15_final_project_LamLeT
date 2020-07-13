//
//  DetailMealTableViewCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation


final class DetailMealTableViewCellViewModel {

    // MARK: - Define
    struct Configure {
        static let urlVideo = "https://www.youtube.com/embed/"
    }

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
        var idVideo: String = ""
        if meal.urlVideoMeal.isEmpty {
            return "No Has Video Tutorial"
        } else {
            if let range = meal.urlVideoMeal.range(of: "=") {
                idVideo = String(meal.urlVideoMeal[range.upperBound...])
            }
        }
        return idVideo
    }
}
