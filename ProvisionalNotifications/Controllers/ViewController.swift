//
//  ViewController.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Props
    var onUserUpdate: BusUnsubscreibe?
    // MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var notify: UIButton!
    
    
    // MARK: - Actions
    @IBAction func explicitNotificationsAccess(_ sender: Any) {
        NotificationManager.instance.explicitAccess { didGrant in
            DispatchQueue.main.async {
                UIApplication.AppDelegate().alert("Explicit Notification Access", didGrant ? "Was Granted" : "Was Denied")
            }
        }
        
    }
    
    @IBAction func implicitNotificationAccess(_ sender: Any) {
        NotificationManager.instance.provisionalAccess { didGrant in
            DispatchQueue.main.async {
                UIApplication.AppDelegate().alert("Provisional Notification Access", didGrant ? "Was Granted" : "Was Denied")
            }
        }
    }
    
    // uses provisional access
    @IBAction func localNotificationAfter5Secs(_ sender: Any) {
        let id = LocalStorage.instance.increment(key: "NotifId")
        let msg = "This is a notification No. \(id)"
        NotificationManager.instance.loacalNotification(message: msg)
    }
    
    @IBAction func remoteNotificationAfter5Secs(_ sender: Any) {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(5)) {
            Api.instance.sendPush(RemoteNotification()) { (res, error) in
                if let e = error {
                    UIApplication.AppDelegate().alert("Error sending remote notification", e.localizedDescription)
                } else {
                    print(res as Any)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        /// Register Event .UserUpdate
        self.onUserUpdate = Bus.shared.on(event: .UserUpdate, cb: { notif in
            DispatchQueue.main.async {
                let usr = LocalStorage.instance.userName
                self.label.text = usr
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        /// De-register Event .UserUpdate
        self.onUserUpdate?()
    }

}

