//
//  AppDelegate.swift
//  HypeiOS27
//
//  Created by Timothy Rosenvall on 7/9/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit
import UserNotifications
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (userDidAllow, error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
            }
            if userDidAllow == true {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        HypeController.sharedInstance.subscribeToRemoteNotifications { (error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error registering APNS : \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        HypeController.sharedInstance.fetchHypes { (success) in
            if success {
                // TODO: - Notification?
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
}

