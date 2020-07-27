//
//  UIViewControllerExt.swift
//  FinalProject
//
//  Created by PCI0002 on 6/30/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: App.String.connectAPI, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: App.String.alertAction, style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func showAlertSearch(message: String) {
        let alert = UIAlertController(title: App.String.alertSearch, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: App.String.alertActionSearch, style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func showAlertSourceLink() {
        let alert = UIAlertController(title: App.String.Source, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: App.String.alertActionSearch, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
