//
//  Bus.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import Foundation


typealias BusUnsubscreibe = () -> Void
/// Conveniece Wrapper For NotificationCenter
struct Bus {
    enum Event: String {
        case UserUpdate
    }
    /* Singleton */
    static let shared = Bus()
    private init() {}
    
    /// Registers a new Event Listener and returns the Unscubscriber method
    func on(event: Bus.Event, cb: (@escaping (_ notif: Notification) -> Void)) -> BusUnsubscreibe {
        let observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(event.rawValue), object: nil, queue: nil, using: cb)
        
        return {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    /// Posts an Event with optional data and info
    func post(event: Bus.Event, data: Any? = nil, info: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(event.rawValue), object: data, userInfo: info)
    }
}
