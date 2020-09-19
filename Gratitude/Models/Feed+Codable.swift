//
//  Feed+Codable.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-19.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

struct FeedContainer: Codable {
    let friend: FriendContainer
    let notes: NoteContainer
    
    enum CodingKeys: String, CodingKey {
        case friend
        case notes
    }
    
}

struct FeedsContainer: Codable {
    let feeds: [FeedContainer]
    
    enum CodingKeys: String, CodingKey {
        case feeds
    }
}
