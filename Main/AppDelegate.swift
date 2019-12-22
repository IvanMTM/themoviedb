//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import App
import Kit
import APIServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootViewController()
        ConfigurationManager.shared.getConfiguration()
        return true
    }
}

// MARK: Private
private extension AppDelegate {
    func setRootViewController() {
        let vc = ListGenreMoviesWireframe().create()
        let navCon = UINavigationController(rootViewController: vc)
        let window = UIWindow()
        window.rootViewController = navCon
        window.makeKeyAndVisible()
        self.window = window
    }
}
