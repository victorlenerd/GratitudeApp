//
//  CreateNoteView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-05.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI
import Firebase

struct CreateNoteView: View {
    @Environment(\.managedObjectContext) var managedContext

    @State private var text = ""
    @State private var textStyle = UIFont.TextStyle.body
    
    var body: some View {
        VStack {
            TextView(text: $text, textStyle: $textStyle)
        }
        .navigationBarTitle("New Note", displayMode: .inline)
        .padding()
        .onDisappear() {
            if self.text.count > 1 {
                let note = Note(context: self.managedContext)
                
                note.createDate = Date()
                note.ownerID = Auth.auth().currentUser?.uid
                note.text = self.text
                note.likes = 0
                note.views = 0
                note.updateDate = Date()
                note.uuid = UUID()
                
                do {
                    try self.managedContext.save()
                    NoteClient.putNote(note: note, isPublic: false) { (_, _) in
                    }
                } catch {
                    fatalError("Failed to create your: \(error.localizedDescription)")
                }
            }
        }
    }
}
