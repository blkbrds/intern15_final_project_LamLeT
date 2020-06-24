//
//  HomeCellCategoryViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/22/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

class HomeCellCategoryViewModel {
    var nameCategory: String
    var urlThumbnail: String
    var thumbnailCategory: UIImage?
    
    init(categoryMeal: CategoryMeal) {
        self.nameCategory = categoryMeal.strCategory
        self.urlThumbnail = categoryMeal.strCategoryThumb
        self.thumbnailCategory = categoryMeal.thumbnail
    }
}
