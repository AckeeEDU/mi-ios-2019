//
//  AppDelegate.swift
//  mi-ios-2019
//
//  Created by Jan Misar on 19/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appFlowCoordinator: AppFlowCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Playground.play()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let userRepository = AppDependency.shared.userRepository

        if CommandLine.arguments.contains("--uitesting") {
            userRepository.logout()
            userRepository.clearData()
            userRepository.register(User.test)
        }

        appFlowCoordinator = AppFlowCoordinator()
        appFlowCoordinator.start(in: window!)
        
        AppDependency.shared.userRepository.currentUser.producer.startWithValues { user in
            if user != nil {
                AppDependency.shared.pushManager.start()
            } else {
                AppDependency.shared.pushManager.stop()
            }
        }
        
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("[DEVICE_TOKEN]", tokenString)
        AppDependency.shared.pushManager.registerToken.apply(tokenString).start()
    }
}
