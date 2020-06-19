//
//  SceneDelegate.swift
//  FinalProject
//
//  Created by Thinh Nguyen X. on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowSence = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowSence)
        let viewController = WelcomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
