//
//  VersionManager.swift
//  Sukedachi
//
//  Created by MBA0237P on 4/16/19.
//  Copyright © 2019 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit.UIApplication

final class VersionManager {

    static let shared = VersionManager()

    private var isShowing = false
    private(set) var needUpdate = false
    var appVersion: String {
        get {
            return userDefaults[.appVersion]
        } set {
            if userDefaults[.appVersion] != newValue {
                Session.shared.lastUpdateCard = nil
            }
            userDefaults[.appVersion] = newValue
        }
    }

    private init() { }

    func forceUpgrade(_ needUpdate: Bool) {
        self.needUpdate = needUpdate
        showAlertForceUpdate()
    }

    func showAlertForceUpdate() {
        // If topVC is alert showUpdate then not show again
        if let topVC = UIApplication.topViewController() as? UIAlertController,
            topVC.preferredStyle == .alert, topVC.title == App.String.titleForceUpdate { return }

        guard let topViewController = UIApplication.topViewController(), !isShowing, needUpdate else { return }
        // Update flag
        isShowing = true
        session.lastUpdateCard = nil
        topViewController.alert(title: App.String.titleForceUpdate,
                                message: App.String.messageForceUpdate,
                                buttons: [App.String.titleActionForceUpdate],
                                canTapOutside: true) { [weak self] _ in
                                    guard let this = self, let url = URL(string: App.Configuration.urlAppStore) else { return }
                                    this.isShowing = false
                                    this.showAlertForceUpdate()
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

        // Handle show again when tap out side
        topViewController.dismissCompletion = { [weak self] in
            guard let this = self else { return }
            this.isShowing = false
            this.showAlertForceUpdate()
        }
    }
}
