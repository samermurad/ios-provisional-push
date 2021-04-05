//
//  NotificationManager.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager {
    /* Singleton */
    static let instance = NotificationManager()
    
    private init() {}
    
    
    func registerProvisionalAccess() {
        self.requestFullAccess { didGrant in
            print(didGrant)
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    func requestFullAccess(_ cb: @escaping (_ didGrant: Bool) -> Void) -> Void {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let center = UNUserNotificationCenter.current()
            DispatchQueue.main.async {
                center.requestAuthorization(options: [.alert, .badge, .sound, .provisional]) { (didGrant, error) in
                    if error != nil {
                        print("An error occured", error ?? "no error")
                        cb(false)
                    } else {
                        cb(true)
                    }
                }
            }
        }
    }
    
    func loacalNotification(message: String, after: TimeInterval = 5, handler: ((_ error: Error?) -> Void)? = nil) {
        self.requestFullAccess { (didGrant) in
            if didGrant {
                DispatchQueue.main.async {
                    let notifId = UUID().uuidString
                    let content = UNMutableNotificationContent()
                    content.body = message
                    content.title = "Quick message"
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: after, repeats: false)
                    let req = UNNotificationRequest(identifier: notifId, content: content, trigger: trigger)
            
                    let center = UNUserNotificationCenter.current()
                    center.add(req, withCompletionHandler: handler)
                }
            }
        }
    }
}
