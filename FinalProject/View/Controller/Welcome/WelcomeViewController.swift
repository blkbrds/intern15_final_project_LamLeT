//
//  WelcomeViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

struct Configure {
    static let title: String = "Cooking"
}

final class WelcomeViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var nextButton: UIButton!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUpUI() {
        super.setUpUI()
        title = Configure.title
        nextButton.cornerRadius = nextButton.height / 2
    }

    // MARK: - Actions
    @IBAction private func nextHomeButtonTouchUpInside(_ sender: Any) {
        self.navigationController?.pushViewController(BaseTabBarViewController(), animated: true)
    }
}
