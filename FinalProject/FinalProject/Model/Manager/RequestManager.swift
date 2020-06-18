//
//  RequestManager.swift
//  Sukedachi
//
//  Created by at-thinhuv on 7/2/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class RequestManager {

    var construction: Construction = Construction()
    var currentDate = Date()
    var prefectures: [Prefecture] = []
    static let shared: RequestManager = RequestManager()

    init() { }

    func getDate(completion: APICompletion? = nil) {
        Api.Common.getDate { (result) in
            switch result {
            case .success(let date):
                self.currentDate = date
                completion?(.success)
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    func getPrefecture(completion: @escaping APICompletion) {
        Api.SignUp.getPrefecture { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let prefectures):
                guard let prefectures = prefectures as? [Prefecture] else {
                    completion(.failure(Api.Error.json))
                    return
                }
                this.prefectures = prefectures
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
