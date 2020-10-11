//
//  File.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-10-11.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

struct UserToken: Codable {
    let FCMToken: String
    
    
    enum CodingKeys: String, CodingKey {
        case FCMToken = "fcm_token"
    }
}
