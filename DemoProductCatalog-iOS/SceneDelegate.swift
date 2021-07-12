//
//  SceneDelegate.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
         
        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene
        
        let navController = UINavigationController()
        let router = ProductListRouter(nav: navController)
        router.start()

        appWindow.rootViewController = navController
        appWindow.makeKeyAndVisible()
        
        window = appWindow
    }

}

