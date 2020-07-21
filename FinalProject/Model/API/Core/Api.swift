//
//  Api.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Api {
    struct Path {
        #if DEBUG
            static let baseURL = "https://dev-asiantech.vn"
        #elseif STG
            static let baseURL = "https://stg-asiantech.vn"
        #else
            static let baseURL = "https://pro-asiantech.vn"
        #endif
        static let pathURL = "https://www.themealdb.com/api/json/v1/1/"
        static let apiListCategory = "\(pathURL)categories.php"
        static let apiMealCategoryAndArea = "\(pathURL)filter.php?"
        static let apiListArea = "\(pathURL)list.php?a=list"
        static let apiDetailMeal = "\(pathURL)lookup.php?"
        static let apiRandomMeal = "\(pathURL)random.php"
        static let apiSearchFirstLetter = "\(pathURL)search.php?f="
        static let apiSearchByName = "\(pathURL)search.php?s="

    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
