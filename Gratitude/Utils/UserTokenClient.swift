//
//  UserTokenClient.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-10-11.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

struct UsersTokenClient {
    
    // MARK:- Get User Feeds
    
    static func putUserToken(userID: String, FCMToken: String, completionHandler: @escaping (_ error: Error?, _ feeds: UserToken?) -> Void) {
        var request = URLRequest(url: URL(string: "\(ENVS.rootURL)/tokens/\(userID)")!)
        
        let body = UserToken(
            FCMToken: FCMToken
        )
        
        let encodedBody = try! JSONEncoder().encode(body)
        let bodyString = String(data: encodedBody, encoding: .utf8)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = bodyString?.data(using: .utf8)
        
        
        let requestClient = RequestClient<UserToken>()
        requestClient.fetch(request: request, completionHandler: completionHandler)
    }
    
}
