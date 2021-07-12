//
//  AppDelegate.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // If iOS 13 is not available, use app delegate to use the function
        if #available(iOS 13.0, *) { } else {
            let appWindow = UIWindow(frame: UIScreen.main.bounds)
            
            let navController = UINavigationController()
            let router = ProductListRouter(nav: navController)
            router.start()

            appWindow.rootViewController = navController
            appWindow.makeKeyAndVisible()
            
            window = appWindow
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

