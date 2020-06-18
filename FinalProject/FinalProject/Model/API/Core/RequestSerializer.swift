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
            if let error = response.error {
                if error.code == Api.Error.connectionAbort.code || error.code == Api.Error.connectionWasLost.code {
                    // Call request one more time when see error 53 or -1_005
                    Alamofire.request(urlString.urlString,
                                      method: method,
                                      parameters: parameters,
                                      encoding: encoding,
                                      headers: tempHeader
                    ).responseJSON { response in
                        DispatchQueue.main.async {
                            completion?(response.result)
                        }
                    }
                } else if error.code == 401, let skError = error.SKError(errorsKey: .exception), skError == .sessionInvalid {
                    AppDelegate.shared.changeRoot(type: .sessionError)
                    DispatchQueue.main.async {
                        completion?(response.result)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion?(response.result)
                    }
                }

            } else {
                DispatchQueue.main.async {
                    completion?(response.result)
                }
            }
        })
        return request
    }
}
