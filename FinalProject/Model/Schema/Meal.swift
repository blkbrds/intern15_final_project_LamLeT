//
//  Meal.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

class Meal {
    var idMeal: String
    var mealName: String
    var category: String
    var area: String
    var instructions: String
    var urlMealThumbnail: String
    var tags: String
    var urlVideoMeal: String?
    var ingredientArray: [String] = []
    var measureArray: [String] = []
    var sourceLink: String?
    var thumbnail: UIImage?

    init(json: JSON) {
        if let idMeal = json["idMeal"] as? String {
            self.idMeal = idMeal
        } else {
            self.idMeal = ""
        }
        if let mealName = json["strMeal"] as? String {
            self.mealName = mealName
        } else {
            self.mealName = ""
        }
        if let category = json["strCategory"] as? String {
            self.category = category
        } else {
            self.category = ""
        }
        if let area = json["strArea"] as? String {
            self.area = area
        } else {
            self.area = ""
        }
        if let instructions = json["strInstructions"] as? String {
            self.instructions = instructions
        } else {
            self.instructions = ""
        }
        if let urlMealThumbnail = json["strMealThumb"] as? String {
            self.urlMealThumbnail = urlMealThumbnail
        } else {
            self.urlMealThumbnail = ""
        }
        if let tags = json["strTags"] as? String {
            self.tags = tags
        } else {
            self.tags = ""
        }
        if let urlVideoMeal = json["strYoutube"] as? String {
            self.urlVideoMeal = urlVideoMeal
        } else {
            self.urlVideoMeal = ""
        }

        var strIngredient = ""
        for i in 1...20 {
            if let ingredient = json["strIngredient\(i)"] as? String, !ingredient.isEmpty {
                strIngredient = "\(i). " + ingredient
                self.ingredientArray.append(strIngredient)
            }
        }
        for i in 1...20 {
            if let measure = json["strMeasure\(i)"] as? String, !measure.isEmpty {
                self.measureArray.append(measure)
            }
        }

        if let strSource = json["strSource"] as? String {
            self.sourceLink = strSource
        }
    }
}

