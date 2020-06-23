//
//  Networking.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation

struct CategoryMealResult {
    var categoryMeals: [CategoryMeal]
}

//MARK: Enum
enum APIResult<T> {
    case failure(String)
    case success(T)
}

//MARK: Typealias
typealias APICompletion<T> = (APIResult<T>) -> Void

class Networking {
    let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"

    private static var sharedNetworking: Networking = {
        let networking = Networking()
        return networking
    }()

    class func shared() -> Networking {
        return sharedNetworking
    }

    func getMeal(apiCompletion: @escaping APICompletion<CategoryMealResult>) {
        guard let url = URL(string: urlString) else {
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
                        let result = CategoryMealResult(categoryMeals: categoryMeals)
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
