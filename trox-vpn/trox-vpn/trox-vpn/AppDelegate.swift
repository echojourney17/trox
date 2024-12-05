//
//  AppDelegate.swift
//  trox-vpn
//
//  Created by Александр on 22.11.2024.
//

import UIKit
import Firebase
import BranchSDK
import SkarbSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator: AppCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        SkarbSDK.initialize(clientId: Constants.skarbID, isObservable: true)
        
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
        
#if DEBUG
        Branch.setUseTestBranchKey(true)
        Branch.setBranchKey(Constants.Branch.testKey)
#endif
        
        storageService.loadRemoteKeys(completion: { [weak self] in
            self?.appCoordinator?.start()

            Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
                print(params as? [String: AnyObject] ?? {})
                
                if let error = error {
                    print("Branch initialization error: \(error.localizedDescription)")
                    return
                }
                
                if let params = params as? [String: AnyObject] {
                    self?.appCoordinator?.receiveBranchParams(params)
                }
            }
        })
        
        return true
    }

}

extension AppDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        Branch.getInstance().application(app, open: url, options: options)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // Handler for Universal Links
        Branch.getInstance().continue(userActivity)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Handler for Push Notifications
        Branch.getInstance().handlePushNotification(userInfo)
    }
    
}
