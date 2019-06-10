//
//  AppDelegate.swift
//  Code Challenge
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // setup nav bar styling
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = .black
        navigationBarAppearace.tintColor = .black
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        return true
    }
}

