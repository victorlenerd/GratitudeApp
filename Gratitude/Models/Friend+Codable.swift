//
//  Friend+Codable.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-19.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

enum FriendRequestStatus: String {
    case Pending = "1"
    case Declined = "2"
    case Approved = "3"
}

struct FriendInfo: Hashable, Codable {
    static func == (lhs: FriendInfo, rhs: FriendInfo) -> Bool {
        lhs.UUID == rhs.UUID
    }
    
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

struct FriendRequest: Hashable, Codable {
    static func == (lhs: FriendRequest, rhs: FriendRequest) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    let uuid:  String
    let userID: String
    let ownerID: String
    var status: String
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case userID = "user_id"
        case status = "status"
        case ownerID = "owner_id"
        case createdDate = "created_date"
    }
    
}

struct FriendContainer: Hashable, Codable {
    static func == (lhs: FriendContainer, rhs: FriendContainer) -> Bool {
        lhs.request.uuid == rhs.request.uuid && lhs.info.UUID == rhs.info.UUID
    }
    
    let request: FriendRequest
    let info: FriendInfo
    
    enum CodingKeys: String, CodingKey {
        case request = "request"
        case info = "info"
    }
    
}
