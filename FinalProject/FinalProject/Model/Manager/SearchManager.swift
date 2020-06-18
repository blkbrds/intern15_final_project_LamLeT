//
//  SearchManager.swift
//  Sukedachi
//
//  Created by MBA0237P on 10/30/19.
//  Copyright © 2019 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class SearchManager {
    
    static var shared = SearchManager()

    // Connect search
    var totalUsers: Int?
    var userParams = UserFilterParams()

    // Site search
    var totalSites: Int?
    var siteParams = SiteFilterParams()

    private init() { }
}
