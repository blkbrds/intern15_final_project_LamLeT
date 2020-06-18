//
//  DataRefreshControl.swift
//  Sukedachi
//
//  Created by MBA0237P on 4/12/19.
//  Copyright © 2019 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class DataRefreshControl {

    private init() {}

    static let shared = DataRefreshControl()

    var hasMessage = false
    var hasSiteGenbaDetail = false 
    var hasMessageAndFilter = false
    var hasNewApplication = false
    var hasNewStatusCard = false
    var hasNewSitleList = false
    var needCreatePay = false
}

extension DataRefreshControl {
    
    func resetData() {
        ApplicationViewController.resetData()
        RegisterInsuranceVC.insurance = Insurance()
        PayCreateViewController.card = SukeCard()
        SiteSearchViewModel.resetData()
        ConnectSearchViewModel.resetData()
    }
}
