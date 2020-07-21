//
//  HomeViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 7/16/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var contentView: UIView!

    private var homePageViewController: HomePageViewController = HomePageViewController()

    private var currentTab: TabType = .category {
        willSet {
            guard newValue != currentTab else { return }
            changeTo(tab: newValue)
        }
    }

    enum TabType: Int {
        case category = 0
        case country

        var title: String {
            switch self {
            case .category:
                return "Category"
            case .country:
                return "Country"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        title = "Home"
        homePageViewController.view.frame = contentView.bounds
        homePageViewController.pageDelegate = self
        contentView.addSubview(homePageViewController.view)
        segmentControl.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
    }

    private func changeTo(tab: TabType) {
        segmentControl.selectedSegmentIndex = tab.rawValue
    }

    @objc func didChangeValue(_ sender: UISegmentedControl) {
        guard let newTab = TabType(rawValue: sender.selectedSegmentIndex) else { return }
        homePageViewController.goToTab(tabType: newTab)
    }
}

extension HomeViewController: HomePageViewControllerDelegate {
    func controller(controller: HomePageViewController, needPerformAction action: HomePageViewController.Action) {
        switch action {
        case .swipe(let tabType):
            currentTab = tabType
        case .pushToController(let vc):
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
