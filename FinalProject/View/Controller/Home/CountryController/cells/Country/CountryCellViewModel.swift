//
//  CountryCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 6/23/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

class CountryCellViewModel {
    var nameArea: String
    var urlFlagCountry: String
    
    init(meal: Meal, urlFlagCountry: String) {
        self.nameArea = meal.area
        self.urlFlagCountry = urlFlagCountry
    }
}
