//
//  NotificationManager.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import Foundation
import UserNotifications
import UIKit


typealias GrantCb = (_ didGrant: Bool) -> Void

class NotificationManager {
    /* Singleton */
    static let instance = NotificationManager()
    
    private init() {}
    
    /// Fire and Forget, Auto Provisional Access
    func registerProvisionalAccess() {
        self.provisionalAccess { didGrant in
            print("did get provisional access: ", didGrant)
        }
    }
    
    func requestAccess(options: UNAuthorizationOptions, cb: GrantCb?) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let center = UNUserNotificationCenter.current()
            DispatchQueue.main.async {
                center.requestAuthorization(options: options) { (didGrant, error) in
                    if error != nil {
                        print("An error occured", error ?? "no error")
                        cb?(false)
                    } else {
                        cb?(true)
                    }
                }
            }
        }
    }

    
    func provisionalAccess( _ cb: GrantCb?) {
        self.requestAccess(options: [.alert, .sound, .badge, .provisional], cb: cb)
    }
    func explicitAccess(_ cb: GrantCb?) {
        self.requestAccess(options: [.alert, .sound, .badge], cb: cb)
    }
    
    func loacalNotification(message: String, after: TimeInterval = 5, handler: ((_ error: Error?) -> Void)? = nil) {
        self.provisionalAccess { (didGrant) in
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
