//
//  AppDelegate.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        NotificationManager.instance.registerProvisionalAccess()
        return true
    }

    func alert(_ title: String, _ msg: String? = nil) {
        DispatchQueue.main.async {
            let cnt = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            cnt.addAction(UIAlertAction(title: "Ok", style: .default, handler: { act in
                cnt.dismiss(animated: true, completion: nil)
            }))
            
            guard let vc = UIApplication.topViewController() else {
                return
            }
            
            vc.present(cnt, animated: true, completion: nil)
        }
    }


    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        guard let token = stringFromDeviceToke(token: deviceToken) else { return }
        var usr = User(token: token)
        usr.userName = LocalStorage.instance.userName
        Api.instance.saveToken(usr) { (user, error) in
            if error != nil {
                print("Error", error as Any)
            } else {
                if let usrName = user?.userName {
                    LocalStorage.instance.userName = usrName
                    Bus.shared.post(event: .UserUpdate)
                }
            }
        }
        
    }
    
    func stringFromDeviceToke(token: Data) -> String? {
        if token.count == 0 { return nil }
        var str = ""
        for i in 0 ..< token.count {
            str += String(format: "%02x", token[i])
        }
        return str
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .list])
        self.alert(notification.request.content.title, notification.request.content.body)
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

