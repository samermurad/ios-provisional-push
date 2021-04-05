//
//  RemoteNotification.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 05.04.21.
//

import Foundation

struct RemoteNotification: Restable {
    var userName: String?
    var token: String?
    var title: String?
    var message: String?
    
    init?(json: Data?) {
        guard let data = json else { return nil }
        guard let object = try? RemoteNotification.fromJson(RemoteNotification.self, data: data) else { return nil }
        self = object
    }
    
    init() {
        self.userName = LocalStorage.instance.userName
    }
    init(title: String, message: String) {
        self.title = title
        self.message = message
        self.userName = LocalStorage.instance.userName
    }
    init(userName: String, title: String, message: String) {
        self.userName = userName
        self.title = title
        self.message = message
    }
    
    init(userName: String, title: String, message: String, token: String) {
        self.userName = userName
        self.title = title
        self.message = message
        self.token = token
    }
}
