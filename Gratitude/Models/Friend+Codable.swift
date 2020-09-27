//
//  Friend+Codable.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-19.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

struct FriendInfo: Codable {
    let UUID: String
    let UID: String
    let DisplayName: String
    let Email: String
    
    enum CodingKeys: String, CodingKey {
        case UUID = "uuid"
        case UID = "uid"
        case DisplayName = "display_name"
        case Email = "email"
    }
}


struct FriendRequestContainer: Codable {
    let uuid:  String
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

struct FriendRequest: Codable {
    let uuid:  String
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

struct FriendContainer: Codable {
    let request: FriendRequest
    let friend: FriendInfo
    
    enum CodingKeys: String, CodingKey {
        case request = "request"
        case friend = "friend"
    }
    
}
