//
//  AppDelegate.swift
//  trox-vpn
//
//  Created by Александр on 22.11.2024.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator: AppCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storageService: StorageServiceInterface = StorageService()
        let appCoordinator = AppCoordinator(
            navigationController: navigationController,
            storageService: storageService
        )
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        self.appCoordinator = appCoordinator
        appCoordinator.start()
//        self.setupApperance()
        
        // Override point for customization after application launch.
        return true
    }

}

