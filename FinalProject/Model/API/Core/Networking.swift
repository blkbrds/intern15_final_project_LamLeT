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
                    if let data = data {
                        let json = data.toJSON()
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
                } else {
                    if let data = data {
                        let json = data.toJSON()
                        let meals = json["meals"] as! [JSON]
                        var categoryDetails: [Meal] = []
                        for item in meals {
                            let meals = Meal(json: item)
                            categoryDetails.append(meals)
                        }
                        let result = MealResult(meals: categoryDetails)
                        completion(.success(result))
                    } else {
                        completion(.failure(App.String.alertFailedToDataAPI))
                    }
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
                } else {
                    if let data = data {
                        let json = data.toJSON()
                        let meals = json["meals"] as! [JSON]
                        var areas: [Meal] = []
                        for item in meals {
                            let area = Meal(json: item)
                            areas.append(area)
                        }
                        let result = MealResult(meals: areas)
                        completion(.success(result))
                    } else {
                        completion(.failure(App.String.alertFailedToDataAPI))
                    }
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
                } else {
                    if let data = data {
                        let json = data.toJSON()
                        let meals = json["meals"] as! [JSON]
                        var areaDetails: [Meal] = []
                        for item in meals {
                            let meals = Meal(json: item)
                            areaDetails.append(meals)
                        }
                        let result = MealResult(meals: areaDetails)
                        completion(.success(result))
                    } else {
                        completion(.failure(App.String.alertFailedToDataAPI))
                    }
                }
            }
        }
        task.resume()
    }
}
