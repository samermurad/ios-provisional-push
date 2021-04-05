//
//  Api.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import Foundation
import UIKit

typealias ResCallback<T> = (_ data: T?, _ error: Error?) -> Void
struct Api {
    /* Singleton */
    static let instance = Api()
    let url: String
    private init() {
        url = Bundle.main.infoDictionary?["API_URL"] as! String
    }
    
    /// Base Request Object
    private func getBaseRequest(path: String) -> NSMutableURLRequest {
        let req = NSMutableURLRequest()
        req.url = URL(string: url + path)
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        return req
    }
    
    
    /// Base URLRequest Handling
    private func sendReq<T: Restable>(req: NSMutableURLRequest, cb: ResCallback<T>?) {
        let session = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: { (data, res, error) in
            if error != nil {
                print(error as Any)
                cb?(nil, error)
            } else {
                if let data = T(json: data) {
                    cb?(data, nil)
                } else {
                    cb?(nil, nil)
                }
            }
        })
        session.resume()
    }

    /// POST Request Save User + Token
    func saveToken(_ user: User, cb: ResCallback<User>?) {
        let req = self.getBaseRequest(path: "/save")
        req.httpMethod = "POST"
        req.httpBody = try! user.toJson()
        self.sendReq(req: req, cb: cb)
    }
    
    /// Send push to Device
    func sendPush(_ notif: RemoteNotification, cb: ResCallback<SendResponse>?) {
        let req = self.getBaseRequest(path: "/send")
        req.httpMethod = "POST"
        req.httpBody = try! notif.toJson()
        self.sendReq(req: req, cb: cb)
    }
}
