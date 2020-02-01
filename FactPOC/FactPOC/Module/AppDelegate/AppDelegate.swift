//
//  AppDelegate.swift
//  FactPOC
//
//  Created by User on 2/1/20.
//  Copyright © 2020 VK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeRouter.createModule()
        window?.makeKeyAndVisible()
        setupNavigationBarAppearance()
        return true
    }
    
    //MARK:- Customize Navigation Bar Appearence
    func setupNavigationBarAppearance() {
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().tintColor = UIColor(named: "navbarColor")
        } else {
            UINavigationBar.appearance().tintColor = UIColor(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0)
        }
        UINavigationBar.appearance().isTranslucent = true
        let navbarTitleAtt = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        UINavigationBar.appearance().titleTextAttributes = navbarTitleAtt
    }
}

