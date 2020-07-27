//
//  Networking.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

struct CategoryResult {
    var categories: [CategoryMeal]
}

struct MealResult {
    var meals: [Meal]
}

struct MealDetailResult {
    var meal: Meal
}

//MARK: Enum
enum APIResult<T> {
    case failure(String)
    case success(T)
}

//MARK: Typealias
typealias APICompletion<T> = (APIResult<T>) -> Void

class Networking {

    // MARK: - Singleton
    private static var sharedNetworking: Networking = {
        let networking = Networking()
        return networking
    }()

    class func shared() -> Networking {
        return sharedNetworking
    }

    // MARK: - Public Functions
    func getCategory(completion: @escaping APICompletion<CategoryResult>) {
        guard let url = URL(string: Api.Path.apiListCategory) else {
            completion(.failure(App.String.alertFailedAPI))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, respone, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(App.String.alertFailedToConnectAPI))
                } else {
                    if let data = data, let json = data.toJSON() {
                        let categories = json["categories"] as! [JSON]
                        var categoryMeals: [CategoryMeal] = []
                        for item in categories {
                            let categoryMeal = CategoryMeal(json: item)
                            categoryMeals.append(categoryMeal)
                        }
                        let result = CategoryResult(categories: categoryMeals)
                        completion(.success(result))
                    } else {
                        completion(.failure(App.String.alertFailedToDataAPI))
                    }
                }
            }
        }
        task.resume()
    }

    func getMealForCategory(categoryName: String, completion: @escaping APICompletion<MealResult>) {
        guard let url = URL(string: Api.Path.apiMealCategoryAndArea + "c=\(categoryName)") else {
            completion(.failure(App.String.alertFailedAPI))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, respone, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(App.String.alertFailedToConnectAPI))
                } else if let data = data, let json = data.toJSON(), let meals = json["meals"] as? [JSON] {
                    var categoryDetails: [Meal] = []
                    for item in meals {
                        let meals = Meal(json: item)
                        categoryDetails.append(meals)
                    }
                    let result = MealResult(meals: categoryDetails)
                    completion(.success(result))
                } 
            }
        }
        task.resume()
    }

    func getArea(completion: @escaping APICompletion<MealResult>) {
        guard let url = URL(string: Api.Path.apiListArea) else {
            completion(.failure(App.String.alertFailedAPI))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, respone, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(App.String.alertFailedToConnectAPI))
                } else if let data = data, let json = data.toJSON(), let meals = json["meals"] as? [JSON] {
                    var areas: [Meal] = []
                    for item in meals {
                        let area = Meal(json: item)
                        areas.append(area)
                    }
                    let result = MealResult(meals: areas)
                    completion(.success(result))
                }
            }
        }
        task.resume()
    }

    func getMealDetailArea(areaName: String, completion: @escaping APICompletion<MealResult>) {
        guard let url = URL(string: Api.Path.apiMealCategoryAndArea + "a=\(areaName)") else {
            completion(.failure(App.String.alertFailedAPI))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, respone, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(App.String.alertFailedToConnectAPI))
                } else if let data = data, let json = data.toJSON(), let meals = json["meals"] as? [JSON] {
                    var areaDetails: [Meal] = []
                    for item in meals {
                        let meal = Meal(json: item)
                        areaDetails.append(meal)
                    }
                    let result = MealResult(meals: areaDetails)
                    completion(.success(result))
                }
            }
        }
        task.resume()
    }

    func getMealDetail(idMeal: String, completion: @escaping APICompletion<MealDetailResult>) {
        guard let url = URL(string: Api.Path.apiDetailMeal + "i=\(idMeal)") else {
            completion(.failure(App.String.alertFailedAPI))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, respone, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(App.String.alertFailedToConnectAPI))
                } else if let data = data, let json = data.toJSON(), let meals = json["meals"] as? [JSON] {
                    var detailMeal: Meal?
                    for item in meals {
                        let meal = Meal(json: item)
                        detailMeal = meal
                    }
                    guard let mealResult = detailMeal else { return }
                    let result = MealDetailResult(meal: mealResult)
                    completion(.success(result))
                }
            }
        }
        task.resume()
    }

    func getMealRandom(completion: @escaping APICompletion<MealResult>) {
        guard let url = URL(string: Api.Path.apiRandomMeal) else {
            completion(.failure(App.String.alertFailedAPI))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(App.String.alertFailedToConnectAPI))
                } else if let data = data, let json = data.toJSON(), let meals = json["meals"] as? [JSON] {
                    var randomMeals: [Meal] = []
                    for item in meals {
                        let meal = Meal(json: item)
                        randomMeals.append(meal)
                    }
                    let result = MealResult(meals: randomMeals)
                    completion(.success(result))
                }
            }
        }
        task.resume()
    }

    func searchMealFirstLetter(firstLetter: String, completion: @escaping APICompletion<MealResult>) {
        guard let url = URL(string: Api.Path.apiSearchFirstLetter + firstLetter) else {
            completion(.failure(App.String.alertFailedAPI))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(App.String.alertFailedToConnectAPI))
                } else if let data = data, let json = data.toJSON(), let meals = json["meals"] as? [JSON] {
                    var searchMeals: [Meal] = []
                    for item in meals {
                        let meal = Meal(json: item)
                        searchMeals.append(meal)
                    }
                    let result = MealResult(meals: searchMeals)
                    completion(.success(result))
                }
            }
        }
        task.resume()
    }

    func searchMealByName(name: String, completion: @escaping APICompletion<MealResult>) {
        guard let url = URL(string: Api.Path.apiSearchByName + name) else {
            completion(.failure(App.String.alertFailedAPI))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(App.String.alertFailedToConnectAPI))
                } else if let data = data, let json = data.toJSON(), let meals = json["meals"] as? [JSON] {
                    var searchMeals: [Meal] = []
                    for item in meals {
                        let meal = Meal(json: item)
                        searchMeals.append(meal)
                    }
                    let result = MealResult(meals: searchMeals)
                    completion(.success(result))
                }
            }
        }
        task.resume()
    }
}
