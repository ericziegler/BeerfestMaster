//
//  AppDelegate.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/8/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // UI
    applyApplicationAppearanceProperties()
    
    if let tabBarController = self.window?.rootViewController as? UITabBarController {
      let tabBar = tabBarController.tabBar
      applyIconColorsFor(tabBar: tabBar)
    }
    
    // Analytics
    let sessionBuilder = FlurrySessionBuilder.init().withCrashReporting(false).withLogLevel(FlurryLogLevelAll)
    Flurry.startSession("44DF4XRKFWVT8HMJ3S7S", with: sessionBuilder)
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
  
  }

  func applicationDidEnterBackground(_ application: UIApplication) {

  }

  func applicationWillEnterForeground(_ application: UIApplication) {

  }

  func applicationDidBecomeActive(_ application: UIApplication) {

  }

  func applicationWillTerminate(_ application: UIApplication) {

  }

}

