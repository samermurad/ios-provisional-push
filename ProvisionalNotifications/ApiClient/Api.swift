//
//  Api.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import Foundation
import UIKit

struct Api {
    /* Singleton */
    static let instance = Api()
    let url: String
    private init() {
        url = Bundle.main.infoDictionary?["API_URL"] as! String
    }
    
    func saveToken(_ user: User, cb: ((_ user: User?, _ error: Error?) -> Void)?) {
        let req = NSMutableURLRequest()
        
        req.url = URL(string: url + "/save")
        
        req.httpMethod = "POST"
        req.httpBody = try! user.toJson()
        
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: { (data, res, error) in
            if error != nil {
                print(error as Any)
                cb?(nil, error)
            } else {
                if let user = User(json: data) {
                    cb?(user, nil)
                } else {
                    cb?(nil, nil)
                }
            }
        })
        session.resume()
    }
}
