//
//  AppDelegate.swift
//  BotterSDKSample
//
//  Created by Nora on 6/7/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
import Botter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // to show chat icon over entir app
        Botter.chatTitle = "Welcome to al dwaa pharmacies\nاهلاً و سهلاً بكم"
        Botter.show(APIKey: "nKmovPCdWNZ")
//        BotterSDK.openChatScreen()
//        BotterSDK.openChatScreen(in: <#T##UIViewController#>)
        return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url.absoluteString)
        return true
    }

}

 
