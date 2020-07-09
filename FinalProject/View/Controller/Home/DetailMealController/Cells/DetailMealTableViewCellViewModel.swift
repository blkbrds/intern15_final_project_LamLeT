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

    init(meal: Meal) {
        self.meal = meal
    }

    // MARK: - Functions
    func getLinkVideo() -> String {
        var idVideo: String = ""
        if meal.urlVideoMeal == "" {
            return "No Has Video Tutorial"
        } else {
            let arrayURLVideo = Array(meal.urlVideoMeal)
            for i in 0...arrayURLVideo.count - 1 {
                if arrayURLVideo[i] == "=" {
                    let idVideoArray = arrayURLVideo[i + 1 ..< arrayURLVideo.endIndex]
                    idVideo = String(idVideoArray)
                }
            }
        }
        return idVideo
    }
}
