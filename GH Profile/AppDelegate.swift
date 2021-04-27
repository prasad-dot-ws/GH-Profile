//
//  AppDelegate.swift
//  GH Profile
//
//  Created by Prasad De Zoysa on 4/27/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
                let viewC = GHViewController()
                let nav = UINavigationController(rootViewController: viewC)
                window?.rootViewController = nav
                window?.makeKeyAndVisible()
        return true
    }


}

