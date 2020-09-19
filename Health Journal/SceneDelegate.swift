//
//  SceneDelegate.swift
//  Health Journal
//
//  Created by Sadrac Tijerina on 8/26/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//

import CareKit
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manager = appDelegate.synchronizedStoreManager
        let contentView = UINavigationController(rootViewController: ContentView(storeManager: manager))

        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = contentView
            window?.tintColor = UIColor { $0.userInterfaceStyle == .light ? #colorLiteral(red: 0.2408578992, green: 0.6738678217, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0.2834656835, blue: 0.6651299596, alpha: 1) }
            window?.makeKeyAndVisible()
        }
    }
}
