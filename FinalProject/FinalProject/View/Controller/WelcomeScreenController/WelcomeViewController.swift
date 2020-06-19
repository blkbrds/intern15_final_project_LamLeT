//
//  WelcomeViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var nextButtonTouchUpInside: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButtonTouchUpInside.layer.cornerRadius = 20
        nextButtonTouchUpInside.layer.borderWidth = 0

    }

    @IBAction func nextHomeButtonTouchUpInside(_ sender: Any) {
        let vc = BaseTabBarViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
