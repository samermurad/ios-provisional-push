//
//  LocalStorage.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import Foundation


/// Basic Implementation For Localstorage using UserDefaults
class LocalStorage {
    /* Singleton */
    static let instance = LocalStorage()
    private init() {}
    
    
    /// Set/Get Persistent UserName (__username__)
    var userName: String? {
        get {
            return UserDefaults.standard.string(forKey: "__username__")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "__username__")
            UserDefaults.standard.synchronize()
        }
    }
    
    /// Convenience method for increamenting Ints by a specified Key
    /// Key is created and set to 1 if didn't exist
    func increment(key: String) -> Int {
        let data = UserDefaults.standard
        let num = data.integer(forKey: key)
        data.set(num + 1, forKey: key)
        UserDefaults.standard.synchronize()
        return num + 1
    }
}
