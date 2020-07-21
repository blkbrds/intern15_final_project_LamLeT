//
//  WelcomeViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

struct Configure {
    static let title: String = "Welcome"
}

final class WelcomeViewController: BaseViewController {

    // MARK: - IBOutlet
   // @IBOutlet private weak var nextButton: UIButton!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUpUI() {
        super.setUpUI()
        title = Configure.title
    }

    // MARK: - Actions
//    @IBAction private func nextHomeButtonTouchUpInside(_ sender: Any) {
//        SceneDelegate.shared.changeRoot()
//    }
}
