//
//  User.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import Foundation

struct User: Restable {
    var userName: String?
    var token: String?
    
    init(token: String) {
        self.token = token
    }

    init?(json: Data?) {
        guard let data = json else { return nil }
        guard let object = try? User.fromJson(User.self, data: data) else { return nil }
        
        self = object
    }
}
