//
//  Note+Network.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-13.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

struct NoteClient {
    
    // MARK:- Put Note Request
    
    static func putNote(note: Note, completionHandler: @escaping (_ error: Error?, _ note: NoteContainer?) -> Void ) {
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
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = bodyString?.data(using: .utf8)
        
        let requestClient = RequestClient<NoteContainer>()
        requestClient.fetch(request: request, completionHandler: completionHandler)
    }
    
    // MARK:- Get User Notes
    
    static func getUserNotes(userID: String, completionHandler: @escaping (_ error: Error?, _ notes: [NoteContainer]?) -> Void) {
        
        var request = URLRequest(url: URL(string: "\(ENVS.rootURL)/notes")!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestClient = RequestClient<[NoteContainer]>()
        requestClient.fetch(request: request, completionHandler: completionHandler)
    }
    
    // MARK:- Delete User Note
    
    static func deleteNote(noteUUID: String, completionHandler: @escaping (_ error: Error?, _ note: NoteContainer?) -> Void) {
        var request = URLRequest(url: URL(string: "\(ENVS.rootURL)/notes/\(noteUUID)")!)
        
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestClient = RequestClient<NoteContainer>()
        requestClient.fetch(request: request, completionHandler: completionHandler)
    }
    
}
