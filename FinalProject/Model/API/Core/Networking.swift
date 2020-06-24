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

struct CategoryMealResult {
    var categoryMeals: [Meal]
}

//MARK: Enum
enum APIResult<T> {
    case failure(String)
    case success(T)
}

//MARK: Typealias
typealias APICompletion<T> = (APIResult<T>) -> Void

class Networking {

    // MARK: - Properties
    let apiListCategory = "https://www.themealdb.com/api/json/v1/1/categories.php"
    let apiMealCategory = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    let apiListArea = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"

    // MARK: - Singleton
    private static var sharedNetworking: Networking = {
        let networking = Networking()
        return networking
    }()

    class func shared() -> Networking {
        return sharedNetworking
    }

    // MARK: - Public Functions
    func getCategory(apiCompletion: @escaping APICompletion<CategoryResult>) {
        guard let url = URL(string: apiListCategory) else {
            apiCompletion(.failure("Failed"))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, respone, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    apiCompletion(.failure("Can't Connect"))
                } else {
                    if let data = data {
                        let json = data.toJSON()
                        let categories = json["categories"] as! [JSON]
                        var categoryMeals: [CategoryMeal] = []
                        for item in categories {
                            let categoryMeal = CategoryMeal(json: item)
                            categoryMeals.append(categoryMeal)
                        }
                        let result = CategoryResult(categories: categoryMeals)
                        apiCompletion(.success(result))
                    } else {
                        apiCompletion(.failure("Connect Failed"))
                    }
                }
            }
        }
        task.resume()
    }

    func getMealForCategory(categoryName: String, apiCompletion: @escaping APICompletion<CategoryMealResult>) {
        guard let url = URL(string: apiMealCategory + "\(categoryName)") else {
            apiCompletion(.failure("Failed"))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, respone, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    apiCompletion(.failure("Can't Connect"))
                } else {
                    if let data = data {
                        let json = data.toJSON()
                        let meals = json["meals"] as! [JSON]
                        var categoryDetails: [Meal] = []
                        for item in meals {
                            let meals = Meal(json: item)
                            categoryDetails.append(meals)
                        }
                        let result = CategoryMealResult(categoryMeals: categoryDetails)
                        apiCompletion(.success(result))
                    } else {
                        apiCompletion(.failure("Connect Failed"))
                    }
                }
            }
        }
        task.resume()
    }
    
    func getArea(apiCompletion: @escaping APICompletion<CategoryMealResult>) {
        guard let url = URL(string: apiListArea) else {
            apiCompletion(.failure("Failed"))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, respone, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    apiCompletion(.failure("Can't Connect"))
                } else {
                    if let data = data {
                        let json = data.toJSON()
                        let meals = json["meals"] as! [JSON]
                        var areas: [Meal] = []
                        for item in meals {
                            let area = Meal(json: item)
                            areas.append(area)
                        }
                        let result = CategoryMealResult(categoryMeals: areas)
                        apiCompletion(.success(result))
                    } else {
                        apiCompletion(.failure("Connect Failed"))
                    }
                }
            }
        }
        task.resume()
    }
}
