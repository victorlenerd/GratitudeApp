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
    let status: Int
        
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case userID = "user_id"
        case ownerID = "owner_id"
        case status = "status"
    }
    
}


struct FriendClient {
    
    
    // MARK:- Search By Email
    
    func searchByEmail(email: String, completionHandler: @escaping (_ friend: FriendContainer?, _ error: Error?) -> Void) {
        
    }
    
    // MARK:- Get User Friends
    
    func getUserFriends(userID: String, completionHandler: @escaping (_ friends: [FriendContainer]?, _ error: Error?) -> Void) {
        
    }
    
    // MARK:- Create Friend Request
    
    func createFriendRequest(userID: String, friendID: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        
    }
    
    // MARK:- Approve Friend Request
    
    func approveFriendRequest(friend: Friend, completionHandler: @escaping (_ error: Error?) -> Void) {
        
    }
    
    // MARK:- Decline Friend Request
    
    func declineFriendRequest(friend: Friend, completionHandler: @escaping (_ error: Error?) -> Void) {
        
    }
    
    // MARK:- Delete Friend
    
    func deleteFriend(uuid: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        
    }
}
