//
//  User.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import Foundation

struct User: Codable {
    var userName: String?
    var token: String?
    
    init(token: String) {
        self.token = token
    }

    init?(json: Data?) {
        let decoder = JSONDecoder()
        guard let data = json else {
            return nil
        }
        guard let object = try? decoder.decode(User.self, from: data) else {
            return nil
        }
        
        self = object
    }
    
    func toJson() throws -> Data {        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}
