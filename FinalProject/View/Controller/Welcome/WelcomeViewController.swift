//
//  WelcomeViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

private struct Configure {
    static let title: String = "Welcome"
}

final class WelcomeViewController: BaseViewController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUpUI() {
        super.setUpUI()
        title = Configure.title
    }

}
