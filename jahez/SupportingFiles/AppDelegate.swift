//
//  AppDelegate.swift
//  jahez
//
//  Created by hammam abdulaziz on 22/06/1443 AH.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
            window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = UINavigationController(rootViewController: HomeView())
        window?.makeKeyAndVisible()
        return true
    }
}

