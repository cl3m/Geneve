//
//  AppDelegate.swift
//  Test
//
//  Created by Clem on 17.02.18.
//  Copyright © 2018 Clem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.isStatusBarHidden = false
        setupAnalytics()
        return true
    }
    
    private func setupAnalytics() {
        GAI.sharedInstance().tracker(withTrackingId: "UA-2996920-7")
    }
}

