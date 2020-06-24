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
//        let homeVC = HomeCategoryViewController()
        let homeVC = CountryViewController()
        let homeNavi = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ic_tabbar_home"), tag: 0)
        
        let searchVC = SearchViewController()
        let searchNavi = UINavigationController(rootViewController: searchVC)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "ic_tabbar_search"), tag: 1)

        let favoritesVC = FavoritesViewController()
        let favoritesNavi = UINavigationController(rootViewController: favoritesVC)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "heart"), tag: 2)

        self.viewControllers = [homeNavi, searchNavi, favoritesNavi]
        self.selectedIndex = 0
        self.tabBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.tabBar.barTintColor = #colorLiteral(red: 0.9921568627, green: 0.8117648363, blue: 0.1843136251, alpha: 1)
        self.tabBar.unselectedItemTintColor = .white
    }
}
