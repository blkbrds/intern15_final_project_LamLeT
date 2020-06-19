//
//  WelcomeViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

private struct Configure {
    static let corner: CGFloat = 40
    static let borderWith: CGFloat = 0
}

final class WelcomeViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var nextButtonTouchUpInside: UIButton!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButtonTouchUpInside.layer.cornerRadius = Configure.corner
        nextButtonTouchUpInside.layer.borderWidth = Configure.borderWith
    }

    // MARK: - Actions
    @IBAction private func nextHomeButtonTouchUpInside(_ sender: Any) {
        let vc = BaseTabBarViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
