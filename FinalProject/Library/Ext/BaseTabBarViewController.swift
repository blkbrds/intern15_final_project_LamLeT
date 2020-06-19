//
//  BaseTabBarViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import Foundation
import UIKit

final class BaseTabBarViewController: UITabBarController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Function
    private func setupUI() {
        let homeVC = HomeCategoryViewController()
        let homeNavi = UINavigationController(rootViewController: homeVC)
        homeNavi.navigationBar.isHidden = true
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)

        let searchVC = SearchViewController()
        let mapNavi = UINavigationController(rootViewController: searchVC)
        mapNavi.navigationBar.isHidden = true
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 1)

        let favoritesVC = FavoritesViewController()
        let favoritesNavi = UINavigationController(rootViewController: favoritesVC)
        favoritesNavi.navigationBar.isHidden = true
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)

        self.viewControllers = [homeNavi, mapNavi, favoritesNavi]
        self.selectedIndex = 0
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .black
        
        
    }
}
