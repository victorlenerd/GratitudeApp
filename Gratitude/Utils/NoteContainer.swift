//
//  Note+Network.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-13.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation


struct NoteContainer: Codable {
    
    let text: String
    let isPublic: Bool
    let likes: Int64
    let uuid: UUID
    let views: Int64
    let ownerID: String
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case text = "text"
        case isPublic = "is_public"
        case likes = "likes"
        case views = "views"
        case ownerID = "ownerID"
    }

}

struct NoteClient {
    
    // MARK:- Put Note Request
    
    static func putNote(note: Note, completionHandler: @escaping (_ error: Error?) -> Void ) {
        var request = URLRequest(url: URL(string: "\(ENVS.rootURL)/notes")!)
        
        let noteBody = NoteContainer(
            text: note.text!,
            isPublic: note.isPublic,
            likes: note.likes,
            uuid: note.uuid!,
            views: note.views,
            ownerID: note.ownerID!
        )
        
        let encodedBody = try! JSONEncoder().encode(noteBody)
        let bodyString = String(data: encodedBody, encoding: .utf8)
        
        request.httpMethod = "PUT"
        request.httpBody = bodyString?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let httpStatusCode = (response as? HTTPURLResponse)?.statusCode else {
                completionHandler(GenericError.Unknown)
                return
            }
            
            if error != nil {
                completionHandler(error)
                return
            }
            
            
            if httpStatusCode >= 200 && httpStatusCode < 300 {
                completionHandler(nil)
            } else {
                completionHandler(GenericError.Unknown)
            }
        }.resume()
    }
    
    // MARK:- Get User Notes
    
    static func getUserNotes(userID: String, completionHandler: @escaping (_ notes: [NoteContainer], _ error: Error?) -> Void) {
        
    }
    
    // MARK:- Delete User Note
    
    static func getUserNotes(userID: String, noteUUID: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        
    }
    
}
