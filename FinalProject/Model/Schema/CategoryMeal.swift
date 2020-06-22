//
//  CategoryMeal.swift
//  FinalProject
//
//  Created by PCI0002 on 6/22/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

class CategoryMeal {
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var thumbnail: UIImage?
    
    init(json: JSON) {
        if let idCategory = json["idCategory"] as? String {
            self.idCategory = idCategory
        } else {
            self.idCategory = ""
        }
        if let strCategory = json["strCategory"] as? String {
            self.strCategory = strCategory
        } else {
            self.strCategory = ""
        }
        if let strCategoryThumb = json["strCategoryThumb"] as? String {
            self.strCategoryThumb = strCategoryThumb
        } else {
            self.strCategoryThumb = ""
        }
    }
}
