//
//  AppDelegate.swift
//  Matrix Tools
//
//  Created by Wangyiwei on 2020/5/1.
//  Copyright © 2020 Wangyiwei. All rights reserved.
//

import UIKit
import Intents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        guard userActivity?.interaction == nil else  {
            return false
        }
        return true
    }
}

