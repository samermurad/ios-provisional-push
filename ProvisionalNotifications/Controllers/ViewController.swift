//
//  ViewController.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var notify: UIButton!
    
    @IBAction func notificationAct(_ sender: Any) {
        let id = LocalStorage.instance.increment(key: "NotifId")
        let msg = "This is a notification No. \(id)"
        NotificationManager.instance.loacalNotification(message: msg)
    }
    
    var onUserUpdate: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.text = "Unset"
    }

    override func viewWillAppear(_ animated: Bool) {
        self.onUserUpdate = Bus.shared.on(event: .UserUpdate, cb: { notif in
            DispatchQueue.main.async {
                let usr = LocalStorage.instance.userName
                self.label.text = usr
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.onUserUpdate?()
    }

}

