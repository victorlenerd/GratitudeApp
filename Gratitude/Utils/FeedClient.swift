//
//  FeedContainer.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-14.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

struct FeedsClient {
    
    // MARK:- Get User Feeds
    
    static func getUserFeeds(userID: String, completionHandler: @escaping (_ error: Error?, _ feeds: [FeedContainer]?) -> Void) {
        var request = URLRequest(url: URL(string: "\(ENVS.rootURL)/feeds/\(userID)")!)
        request.httpMethod = "GET"
        
        let requestClient = RequestClient<[FeedContainer]>()
        requestClient.fetch(request: request, completionHandler: completionHandler)
    }
    
}
