//
//  FriendContainer.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-14.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation


struct FriendClient {
    
    
    static func makeFriendRequest(friendRequest: FriendRequest) -> URLRequest {
        let urlComponent = URLComponents(string: "\(ENVS.rootURL)/friends")!
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encodedBody = try! JSONEncoder().encode(friendRequest)
        let bodyString = String(data: encodedBody, encoding: .utf8)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = bodyString?.data(using: .utf8)
        
        return request
    }
    
    // MARK:- Search By Email
    
    static func searchByEmail(email: String, completionHandler: @escaping (_ error: Error?, _ friend: FriendInfo?) -> Void) {
        var urlComponent = URLComponents(string: "\(ENVS.rootURL)/search")!
    
        urlComponent.queryItems = [
            URLQueryItem(name: "email", value: email)
        ]
        
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let requestClient = RequestClient<FriendInfo>()
        requestClient.fetch(request: request, completionHandler: completionHandler)
    }
    
    // MARK:- Get User Friends
    
    static func getUserFriends(userID: String, completionHandler: @escaping (_ error: Error?, _ friends: [FriendContainer]?) -> Void) {
        let urlComponent = URLComponents(string: "\(ENVS.rootURL)/friends/\(userID)")!

        
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let requestClient = RequestClient<[FriendContainer]>()
        requestClient.fetch(request: request, completionHandler: completionHandler)
    }
    
    // MARK:- Create Friend Request
    
    static func createFriendRequest(ownerID: String, friendInfo: FriendInfo, completionHandler: @escaping (_ error: Error?, _ friend: FriendContainer?) -> Void) {
        let friendRequest = FriendRequest(
                uuid: UUID().uuidString,
                userID: friendInfo.UID,
                ownerID: ownerID,
                status: "1"
            )
        
        let request = self.makeFriendRequest(friendRequest: friendRequest)
        let requestClient = RequestClient<FriendContainer>()
        
        requestClient.fetch(request: request, completionHandler: completionHandler)
    }
    
    // MARK:- Approve Friend Request
    
    static func approveFriendRequest(friendRequest: FriendRequest, completionHandler: @escaping (_ error: Error?, _ friend: FriendContainer?) -> Void) {
        
        let request = self.makeFriendRequest(friendRequest: friendRequest)
        let requestClient = RequestClient<FriendContainer>()
        
        requestClient.fetch(request: request, completionHandler: completionHandler)
        
    }
    
    // MARK:- Decline Friend Request
    
    static func declineFriendRequest(friendRequest: FriendRequest, completionHandler: @escaping (_ error: Error?, _ friend: FriendContainer?) -> Void) {

        let request = self.makeFriendRequest(friendRequest: friendRequest)
        let requestClient = RequestClient<FriendContainer>()
        
        requestClient.fetch(request: request, completionHandler: completionHandler)
        
    }
    
    // MARK:- Delete Friend
    
    static func deleteFriend(uuid: String, completionHandler: @escaping (_ error: Error?, _ friend: FriendContainer?) -> Void) {
        let urlComponent = URLComponents(string: "\(ENVS.rootURL)/friends/\(uuid)")!

        
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let requestClient = RequestClient<FriendContainer>()
        requestClient.fetch(request: request, completionHandler: completionHandler)
    }
}
