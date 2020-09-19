//
//  FriendContainer.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-14.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation


struct FriendContainer: Codable {
    let uuid: String
    let userID: String
    let ownerID: String
    let status: String
        
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case userID = "user_id"
        case ownerID = "owner_id"
        case status = "status"
    }
    
}


struct FriendClient {
    
    
    // MARK:- Search By Email
    
    static func searchByEmail(email: String, completionHandler: @escaping (_ friend: FriendContainer?, _ error: Error?) -> Void) {
        var urlComponent = URLComponents(string: "\(ENVS.rootURL)/search")!
    
        urlComponent.queryItems = [
            URLQueryItem(name: "email", value: email)
        ]
        
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        
        URLSession.shared.dataTask(with: request) { (data: Data?, response, error: Error?) in
            
        }.resume()
    }
    
    // MARK:- Get User Friends
    
    static func getUserFriends(userID: String, completionHandler: @escaping (_ friends: [FriendContainer]?, _ error: Error?) -> Void) {
        
    }
    
    // MARK:- Create Friend Request
    
    static func createFriendRequest(userID: String, friendID: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        
    }
    
    // MARK:- Approve Friend Request
    
    static func approveFriendRequest(friend: Friend, completionHandler: @escaping (_ error: Error?) -> Void) {
        
    }
    
    // MARK:- Decline Friend Request
    
    static func declineFriendRequest(friend: Friend, completionHandler: @escaping (_ error: Error?) -> Void) {
        
    }
    
    // MARK:- Delete Friend
    
    static func deleteFriend(uuid: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        
    }
}
