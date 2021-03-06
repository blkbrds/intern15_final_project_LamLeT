//
//  RequestSerializer.swift
//  Sukedachi
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2016 AsianTech Co., Ltd. All rights reserved.
//

import Alamofire
import Foundation
import ObjectMapper
import SwifterSwift

extension ApiManager {

    @discardableResult
    func request(method: HTTPMethod,
                 urlString: URLStringConvertible,
                 parameters: [String: Any]? = nil,
                 headers: [String: String]? = nil,
                 completion: Completion?) -> Request? {
        guard Network.shared.isReachable else {
            DispatchQueue.main.async {
                completion?(.failure(Api.Error.network))
            }
            return nil
        }

        let encoding: ParameterEncoding
        if method == .post || method == .put || method == .delete {
            encoding = JSONEncoding.default
        } else {
            encoding = URLEncoding.default
        }

        var tempHeader = api.defaultHTTPHeaders
        if let headers = headers {
            tempHeader += headers
        }

        let request = Alamofire.request(urlString.urlString,
                                        method: method,
                                        parameters: parameters,
                                        encoding: encoding,
                                        headers: tempHeader
        ).responseJSON(completion: { (response) in
            DispatchQueue.main.async {
                completion?(response.result)
            }
        })
        return request
    }
}
