//
//  SendResponse.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 05.04.21.
//

import Foundation

struct SendResponse: Restable {
    struct Device: Codable {
        var device: String
    }
    var sent: [Device]?
    var failed: [Device]?
    
    init?(json: Data?) {
        guard let data = json else { return nil }
        guard let object = try? SendResponse.fromJson(SendResponse.self, data: data) else { return nil }
        self = object
    }
}
