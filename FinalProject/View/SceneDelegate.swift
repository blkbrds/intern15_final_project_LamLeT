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

    static let shared: SceneDelegate = {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError("Can not find SceneDelegate")
        }
        return sceneDelegate
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowSence = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowSence)
        let viewController = WelcomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        window.rootViewController = navigationController
        let additionalTime: DispatchTimeInterval = .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: .now() + additionalTime) {
            self.changeRoot()
        }
        self.window = window
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }

    func changeRoot() {
        window?.rootViewController = BaseTabBarViewController()
    }
}
