//
//  ResponseSerializer.swift
//  Sukedachi
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Alamofire
import ObjectMapper

extension Request {
    static func responseJSONSerializer(log: Bool = true,
                                       response: HTTPURLResponse?,
                                       data: Data?,
                                       error: Error?) -> Result<Any> {
        guard let response = response else {
            if let error = error {
                let errorCode = error.code
                if abs(errorCode) == Api.Error.cancelRequest.code { // code is 999 or -999
                    return .failure(Api.Error.cancelRequest)
                }
                return .failure(error)
            }
            return .failure(Api.Error.noResponse)
        }

        print("DEBUGLOG: URL \n\(String(describing: response.url))")
        print("DEBUGLOG: JSON \n\(String(describing: data?.toJSON()))")

        let statusCode = response.statusCode

        if let error = error {
            return .failure(error)
        }

        if 204...205 ~= statusCode { // empty data status code
            return .success([:])
        }

        guard 200...299 ~= statusCode else {
            // Cancel request
            if statusCode == Api.Error.cancelRequest.code {
                return .failure(Api.Error.cancelRequest)
            }
            let err = NSError(
                domain: Api.Path.baseURL.host,
                code: statusCode,
                userInfo: data?.toJSON() as? JSObject
            )
            
            print("------------------------")
            print("Request: \(String(describing: response.url))")
            print("Error: \(err.code) - \(err.localizedDescription)")
            return .failure(err)
        }

        guard let data = data, let json = data.toJSON() else {
            return Result.failure(Api.Error.json)
        }

        if let js = json as? JSObject, let code = js["code"] as? Int {
            guard 200...299 ~= code else {
                let message = js["message"] as? String ?? ""
                let err = NSError(domain: Api.Path.baseURL.host, code: code, message: message)
                return .failure(err)
            }
        }
        if let js = json as? JSObject {
            if let jsData = js["data"] {
                return .success(jsData)
            }
        }
        return .success(json)
    }

    static func responseJSONSerializerApplication(log: Bool = true,
                                                  response: HTTPURLResponse?,
                                                  data: Data?,
                                                  error: Error?) -> Result<Any> {
        guard let response = response else {
            if let error = error {
                let errorCode = error.code
                if abs(errorCode) == Api.Error.cancelRequest.code { // code is 999 or -999
                    return .failure(Api.Error.cancelRequest)
                }
                return .failure(error)
            }
            return .failure(Api.Error.noResponse)
        }

        #if DEBUG
        print("DEBUGLOG-JSON:\(String(describing: response.url))\n\(String(describing: data?.toJSON()))")
        #endif

        let statusCode = response.statusCode

        if let error = error {
            return .failure(error)
        }

        if 204...205 ~= statusCode { // empty data status code
            return .success([:])
        }
        
        guard 200...299 ~= statusCode else {
            // Cancel request
            if statusCode == Api.Error.cancelRequest.code {
                return .failure(Api.Error.cancelRequest)
            }

            let err = NSError(domain: Api.Path.baseURL.host,
                              code: statusCode,
                              userInfo: data?.toJSON() as? JSObject)
            #if DEBUG
            print("------------------------")
            print("DEBUGLOG-Error: \(String(describing: response.url))\n\(err.code) - \(err.localizedDescription)")
            #endif
            return .failure(err)
        }
    
        guard let data = data, let json = data.toJSON() else {
            return Result.success([:])
        }

        return .success(json)
    }
}

extension DataRequest {
    static func responseSerializer() -> DataResponseSerializer<Any> {
        return DataResponseSerializer { _, response, data, error in
            return Request.responseJSONSerializer(log: true,
                                                  response: response,
                                                  data: data,
                                                  error: error)
        }
    }

    static func responseSerializerNew() -> DataResponseSerializer<Any> {
        return DataResponseSerializer { _, response, data, error in
            return Request.responseJSONSerializerApplication(log: true,
                                                  response: response,
                                                  data: data,
                                                  error: error)
        }
    }

    @discardableResult
    func responseJSON(queue: DispatchQueue? = nil,
                      completion: @escaping (DataResponse<Any>) -> Void) -> Self {
        return response(
            responseSerializer: DataRequest.responseSerializer(),
            completionHandler: completion
        )
    }

    @discardableResult
    func responseJSONNew(queue: DispatchQueue? = nil,
                         completion: @escaping (DataResponse<Any>) -> Void) -> Self {
        return response(
            responseSerializer: DataRequest.responseSerializerNew(),
            completionHandler: completion
        )
    }
}
