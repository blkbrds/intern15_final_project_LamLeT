//
//  Strings.swift
//  FinalProject
//
//  Created by Thinh Nguyen X. on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

/**
 This file defines all localizable strings which are used in this application.
 Please localize defined strings in `Resources/Localizable.strings`.
 */

import Foundation

extension App {
    struct String {
        // MARK: - Common
        static let alertFailedAPI = "Failed"
        static let alertFailedToConnectAPI = "Connect Failed"
        static let alertFailedToDataAPI = "Data Covernt To Failed"
        static let connectAPI = "Connect API"
        static let alertAction = "Connect"
        static let iconTable = "icon_tableView"
        static let iconCollection = "icon_collectionView"
        static let iconBack = "icon_back"
        static let titleCountry = "Country"
        static let loadSuccess = "Loading Success"
        static let iconAddFavorites = "heart"
        static let iconRemoveFavorites = "heart.fill"
        static let haveItem = "Item is Favorites"
        static let notHaveItem = "Item not is Favorites"
        static let addObjectSuccess = "Success To Add Object"
        static let addObjectFailed = "Failed To Add Object"
        static let deleteObjectSuccess = "Success To Delete Object"
        static let deleteObjectFailed = "Failed To Delete Object"
        static let fetchData = "Fetch Data Success"
        static let failedFetchData = "Failed Fetch Data"
        static let titleHomeWelcome = "Cooking Junior"
    }
}
