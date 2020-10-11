//
//  NotesView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-05.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI
import Firebase


struct NotesView: View {
    @Environment(\.managedObjectContext) var managedContext

    @EnvironmentObject var appState: AppState
    @FetchRequest(
        entity: Note.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Note.updateDate, ascending: false)
        ]
    ) var notes: FetchedResults<Note>
    
    @State private var gotoLoginScreen: Bool = false
    @State private var createNewNote: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if notes.count > 0 {
                        List(notes, id: \.self) { (note: Note) in
                            NavigationLink(destination: SingleNoteView(note: note)) {
                                VStack(alignment: .leading) {
                                    Text("\(note.text!.description)")
                                        .lineLimit(1)
                                        .padding(.top)
                                }
                            }
                        }.listStyle(PlainListStyle())
                    } else {
                        Text("You don't have any notes yet!")
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .opacity(0.5)
                            .padding(.leading, 50)
                            .padding(.trailing, 50)

                    }
                }
                .navigationBarTitle("Notes", displayMode: .large)
                .navigationBarItems(
                trailing:
                    Button(action: logout) {
                        Text("Log Out")
                    })
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: CreateNoteView(), isActive: self.$createNewNote) {
                            EmptyView()
                        }
                            
                        Button(action: self.addNewNote) {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(Color.blue.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                        .padding(.bottom)
                        .shadow(radius: 10)
                    }
                }
            }
        }
    }
}

// MARK:- Methods

extension NotesView {
    
    // MARK:- Create New Note
    
    func addNewNote() {
        self.createNewNote = true
    }
    
    // MARK:- Logout
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.deleteAllNote()
            appState.isLoggedIn = false
        } catch {
            fatalError("Failed to signout \(error.localizedDescription)")
        }
    }
    
    // MARK:- Delete All Notes
    
    func deleteAllNote() {
        for note in notes {
            managedContext.delete(note)
        }
        
        try? managedContext.save()
    }
    
}
