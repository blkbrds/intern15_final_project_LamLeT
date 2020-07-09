//
//  FavoritesViewModel.swift
//  FinalProject
//
//  Created by PCI0002 on 7/4/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoritesViewModelDelegate: class {
    func viewModel(_ viewModel: FavoritesViewModel, needperfomAction action: FavoritesViewModel.Action)
}

class FavoritesViewModel {
    
    // MARK: - Define
    struct Configure {
        static let fetchData: String = "Fetch Data Success"
        static let failedFetchData: String = "Failed Fetch Data"
        static let deleteObject: String = "Success To Delete Object"
        static let failedDeleteObject: String = "Delete Object Failed"
        static let nameIconDelete: String = "trash"
    }

    // MARK: - Properties
    var title: String = "Meal Favorites"
    var meals: [MealRealm] = []

    enum Action {
        case reloadData
    }

    weak var delegate: FavoritesViewModelDelegate?

    private var notificationToke: NotificationToken?

    // MARK: - Realm Functions
    func setupObserve() {
        let realm = try! Realm()
        notificationToke = realm.objects(MealRealm.self).observe({ (change) in
            self.delegate?.viewModel(self, needperfomAction: .reloadData)
        })
    }

    func fetchData(completion: (Bool, String) -> ()) {
        do {
            // realm
            let realm = try Realm()

            let results = realm.objects(MealRealm.self)

            meals = Array(results)

            completion(true, Configure.fetchData)
        } catch {
            completion(false, Configure.failedFetchData)
        }
    }

    func insertRepo(idMeal: String, nameMeal: String, imageURLMeal: String) {
        let realm = try! Realm()
        let meal = MealRealm()
        meal.idMeal = idMeal
        meal.nameMeal = nameMeal
        meal.imageURLMeal = imageURLMeal

        try! realm.write {
            realm.add(meal)
        }
    }

    func deleteAll(completion: (Bool) -> ()) {
        do {
            let realm = try Realm()

            let results = realm.objects(MealRealm.self)

            try realm.write {
                realm.delete(results)
            }
            completion(true)

        } catch {
            completion(false)
        }
    }

    func deleteOneObject(indexPath: IndexPath, completion: (Bool, String) -> Void) {
        do {
            let realm = try Realm()
            let getItem = meals[indexPath.row]
            let id = getItem.idMeal
            let meal = realm.objects(MealRealm.self).filter("idMeal = '\(id)'")
            if meal.count == 0 {
                completion(false, Configure.failedDeleteObject)
            } else {
                try realm.write {
                    realm.delete(meal)
                    completion(true, Configure.deleteObject)
                }
            }
        } catch {
            completion(false, Configure.failedDeleteObject)
        }
    }

    func heightForRowAt() -> CGFloat {
        return 120
    }

    func favoritesCell(at indexPath: IndexPath) -> FavoritesTableViewModel {
        let item = meals[indexPath.row]
        let viewmodel = FavoritesTableViewModel(meal: item)
        return viewmodel
    }

    func getMeal(at indexPath: IndexPath) -> MealRealm {
        return meals[indexPath.row]
    }

    func numberOfRowsInSection() -> Int {
        return meals.count
    }
}
