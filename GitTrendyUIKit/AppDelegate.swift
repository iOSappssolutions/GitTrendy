//
//  AppDelegate.swift
//  GitTrendyUIKit
//
//  Created by Miroslav Djukic on 20/09/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let repertoiresViewController = RepositoriesViewController()
        let rootController = UINavigationController(rootViewController: repertoiresViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = rootController
        window!.makeKeyAndVisible()
        
        return true
    }


}

