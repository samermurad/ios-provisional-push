//
//  Bus.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import Foundation

struct Bus {
    enum Event: String {
        case UserUpdate
    }
    /* Singleton */
    static let shared = Bus()
    private init() {}
    
    func on(event: Bus.Event, cb: (@escaping (_ notif: Notification) -> Void)) -> () -> Void {
        let observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(event.rawValue), object: nil, queue: nil, using: cb)
        
        return {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func post(event: Bus.Event, data: Any? = nil, info: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(event.rawValue), object: data, userInfo: info)
    }
}
