//
//  Router.swift
//  Sukedachi
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

final class Api {
    struct Path {
        static let domainLaravel = AppConfiguration.infoForKey(.laravelBaseURL).content
        static let baseURL = AppConfiguration.infoForKey(.baseURL).content / "api"
        static let laravelBaseURL = domainLaravel / "api"

        static var v1: String { return "v1" }
    }

    // MARK: - Request

}

extension Api.Path {

    // Code here
}


protocol URLStringConvertible {
    var urlString: String { get }
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
