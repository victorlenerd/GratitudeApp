//
//  Note+Codable.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-19.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

struct NoteContainer: Codable {
    
    let text: String
    let likes: Int64
    let uuid: UUID
    let views: Int64
    let ownerID: String
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case text = "text"
        case likes = "likes"
        case views = "views"
        case ownerID = "ownerID"
    }

}
