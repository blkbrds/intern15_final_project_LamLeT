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
        self.window = window
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        configRootView(vc: WelcomeViewController())
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.configRootView(vc: BaseTabBarViewController())
        }
    }

    func configRootView(vc: UIViewController) {
        let navi = UINavigationController(rootViewController: vc)
        navi.isNavigationBarHidden = true
        window?.rootViewController = navi
    }
}
