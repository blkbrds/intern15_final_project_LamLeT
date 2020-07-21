//
//  HomePageViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 7/16/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

protocol HomePageViewControllerDelegate: class {
    func controller(controller: HomePageViewController, needPerformAction action: HomePageViewController.Action)
}

final class HomePageViewController: UIPageViewController {

    // MARK: - Properties
    enum Action {
        case swipe(toTab: HomeViewController.TabType)
        case pushToController(vc: UIViewController)
    }

    private let subViewControllers: [UIViewController] = [HomeCategoryViewController(), CountryViewController()]

    weak var pageDelegate: HomePageViewControllerDelegate?

    override init(transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        configUI()
    }

    private func configUI() {
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
        (subViewControllers[0] as? HomeCategoryViewController)?.delegate = self
        (subViewControllers[1] as? CountryViewController)?.delegate = self
    }

    func goToTab(tabType: HomeViewController.TabType) {
        switch tabType {
        case .category:
            setViewControllers([subViewControllers[0]], direction: .reverse, animated: true, completion: nil)
        case .country:
            setViewControllers([subViewControllers[1]], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension HomePageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let vc = pendingViewControllers.first,
            let index: Int = subViewControllers.firstIndex(of: vc),
            let tabType = HomeViewController.TabType(rawValue: index) else { return }
        pageDelegate?.controller(controller: self, needPerformAction: .swipe(toTab: tabType))
    }
}

extension HomePageViewController: HomeCategoryViewControllerDelegate {
    func controller(controller: HomeCategoryViewController, needPerformAction action: HomeCategoryViewController.Action) {
        switch action {
        case .pushTo(let vc):
            pageDelegate?.controller(controller: self, needPerformAction: .pushToController(vc: vc))
        }
    }
}

extension HomePageViewController: CountryViewControllerDelegate {
    func controller(_ controller: CountryViewController, needPerformAction action: CountryViewController.Action) {
        switch action {
        case .pushToController(let vc):
            pageDelegate?.controller(controller: self, needPerformAction: .pushToController(vc: vc))
        }
    }
}
