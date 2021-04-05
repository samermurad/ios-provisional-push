//
//  LocalStorage.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import Foundation


class LocalStorage {
    /* Singleton */
    static let instance = LocalStorage()
    private init() {}
    
    
    var userName: String? {
        get {
            return UserDefaults.standard.string(forKey: "__username__")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "__username__")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    func increment(key: String) -> Int {
        let data = UserDefaults.standard
        let num = data.integer(forKey: key)
        data.set(num + 1, forKey: key)
        UserDefaults.standard.synchronize()
        return num + 1
    }
}
