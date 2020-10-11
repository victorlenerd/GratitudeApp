//
//  Note+Codable.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-19.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

struct NoteContainer: Hashable, Codable {
    
    let text: String
    let isPublic: Bool
    let likes: Int64
    let uuid: String
    let views: Int64
    let ownerID: String
    let createDate: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case text = "text"
        case isPublic = "is_public"
        case likes = "likes"
        case views = "views"
        case ownerID = "owner_id"
        case createDate = "create_date"
    }

}
