//
//  ApiManager.swift
//  Sukedachi
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

typealias Completion = (Result<Any>) -> Void
typealias APICompletion = (APIResult) -> Void
typealias DataCompletion<Value> = (Result<Value>) -> Void
typealias ProcessCompletion = () -> Void

enum APIResult {
    case success
    case failure(Error)
}

let api = ApiManager()
let session = Session.shared

extension APIResult: Equatable {

    public static func == (lhs: APIResult, rhs: APIResult) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
        case (.failure(let lhsError), .failure(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

final class ApiManager {

    /**
     var defaultHTTPHeaders: [String: String] {
            var headers: [String: String] = [:]
            headers["Content-Type"] = "application/json"
            return headers
        }
     */
}
