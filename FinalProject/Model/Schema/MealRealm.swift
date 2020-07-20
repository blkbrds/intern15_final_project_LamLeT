//
//  MealRealm.swift
//  FinalProject
//
//  Created by PCI0002 on 7/3/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import RealmSwift

class MealRealm: Object {
    @objc dynamic var idMeal = ""
    @objc dynamic var nameMeal = ""
    @objc dynamic var imageURLMeal = ""
    @objc dynamic var isFavorites = false
    
    override static func primaryKey() -> String? {
        return "idMeal"
    }
}