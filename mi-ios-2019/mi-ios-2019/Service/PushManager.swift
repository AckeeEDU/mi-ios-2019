//
//  PushManager.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 24/04/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import ReactiveSwift
import UserNotifications
import enum Result.NoError

protocol HasPushManager {
    var pushManager: PushManaging { get }
}

protocol PushManaging {
    var registerToken: Action<String, Void, NoError> { get }
    
    var notificationSignal: Signal<AlertNotification, NoError> { get }
    
    func start()
    func stop()
}

final class PushManager: NSObject, PushManaging {
    typealias Dependencies = HasNoDependency
    
    let registerToken: Action<String, Void, NoError>
    let (notificationSignal, notificationObserver) = Signal<AlertNotification, NoError>.pipe()
    
    init(dependencies: Dependencies) {
        registerToken = Action { token in
            return .empty // Send token to API or somewhere else
        }
        
        super.init()
    }
    
    func start() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    func stop() {
        // request to API
        UIApplication.shared.unregisterForRemoteNotifications()
//        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: <#T##([UNNotificationRequest]) -> Void#>)
    }
}

extension PushManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("[NOTIFICATION_RECEIVE]", notification)
        completionHandler([.badge, .alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("[NOTIFICATION_OPEN]", response)
        
        let userInfo = response.notification.request.content.userInfo
        print("[NOTIFICATION_USER_INFO]", userInfo)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: userInfo, options: [])
        
        do {
            let alertNotification = try JSONDecoder().decode(AlertNotification.self, from: jsonData)
            notificationObserver.send(value: alertNotification)
            print("[ALERT_NOTIFICATION]", alertNotification)
        } catch {
            print("[ALERT_NOTIFICATION]", error)
        }
        
        completionHandler()
    }
}
