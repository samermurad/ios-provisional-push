//
//  Restable.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 05.04.21.
//

import Foundation

protocol Restable: Codable {
    init?(json: Data?)
}

extension Restable {
    func toJson() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
    
    static func fromJson<T: Restable>(_ type: T.Type, data: Data) throws -> T {
        return try JSONDecoder().decode(type, from: data)
    }
}
