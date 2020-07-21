//
//  SearchTableCellViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 7/9/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import RealmSwift

class SearchTableCellViewModel {
    var idMeal: String
    var mealName: String
    var urlThumbnail: String
    var isFavorites: Bool = false

    init(meal: Meal) {
        self.idMeal = meal.idMeal
        self.mealName = meal.mealName
        self.urlThumbnail = meal.urlMealThumbnail
    }

    // MARK: - Realm
    func checkFavorites(completion: @escaping(Bool, String) -> Void) {
        do {
            let realm = try Realm()
            let meal = realm.objects(MealRealm.self).filter("idMeal = '\(idMeal)' AND isFavorites = true ")
            if meal.count == 0 {
                isFavorites = true
                completion(false, App.String.notHaveItem)
            } else {
                isFavorites = false
                completion(true, App.String.haveItem)
            }
        } catch {
            completion(false, "")
        }
    }

    func addFavorites(completion: @escaping (Bool, String) -> Void) {
        do {
            let realm = try Realm()

            let meal = MealRealm()
            meal.idMeal = idMeal
            meal.nameMeal = mealName
            meal.imageURLMeal = urlThumbnail
            meal.isFavorites = true
            try realm.write {
                realm.add(meal)
                isFavorites = true
                completion(true, App.String.addObjectSuccess)
            }
        } catch {
            completion(false, App.String.addObjectFailed)
        }
    }

    func deleteFavorites(completion: @escaping (Bool, String) -> Void) {
        do {
            let realm = try Realm()

            let meal = realm.objects(MealRealm.self).filter("idMeal = '\(idMeal)'")

            try realm.write {
                realm.delete(meal)
                isFavorites = false
                completion(true, App.String.deleteObjectSuccess)
            }
        } catch {
            completion(false, App.String.deleteObjectFailed)
        }
    }
}
