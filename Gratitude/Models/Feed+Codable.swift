//
//  Feed+Codable.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-19.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

struct FeedContainer: Hashable, Codable {
    
    static func == (lhs: FeedContainer, rhs: FeedContainer) -> Bool {
        lhs.friend.UID == rhs.friend.UID
    }
    
    let friend: FriendInfo
    let notes: [NoteContainer]?
    
    enum CodingKeys: String, CodingKey {
        case friend = "info"
        case notes = "public_notes"
    }
    
}

struct FeedsContainer: Codable {
    let feeds: [FeedContainer]
    
    enum CodingKeys: String, CodingKey {
        case feeds
    }
}
