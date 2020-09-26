//
//  NoteView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-05.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import CoreData
import SwiftUI
import Firebase

struct SingleNoteView: View {
    @Environment(\.managedObjectContext) var managedContext
    @EnvironmentObject var appState: AppState

    @State private var isNoteOwner: Bool = false
    @State private var noteIsPublic: Bool = false
    @State private var editNote: Bool = false
    @State private var showAlert: Bool = false
    
    @ObservedObject var note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(note.updateDate!.description(with: Locale(identifier: "en_CA")))")
                .font(.system(size: 12))
                .opacity(0.6)
            Divider()
            HStack() {
                if self.isNoteOwner == true {
                    Group {
                        Text("\(note.likes)").font(.system(size: 16, weight: .bold))
                        Text("Likes").font(.system(size: 12))
                        Text("\(note.views)").font(.system(size: 16, weight: .bold))
                        Text("Views").font(.system(size: 12))
                    }
                    Spacer()
                }
                
                if self.isNoteOwner == false {
                    Text("\(note.likes)").font(.system(size: 16, weight: .bold))
                    Button("Like", action: likeNote)
                }
            }
            Divider()
            ScrollView {
                Text(note.text!)
            }
            NavigationLink(destination: ModifyNoteView(note: note), isActive: $editNote) {
                EmptyView()
            }.hidden()
        }
        .onAppear() {
            self.isNoteOwner = Auth.auth().currentUser?.uid == note.ownerID
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Share Note"),
                message: Text("You're about to share your note with friends"),
                primaryButton: .default(Text("Share On Feed"), action: shareOnFeed),
                secondaryButton: .default(Text("Share On Others"), action: shareOnOtherApps)
            )
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                if isNoteOwner {
                    Button(action: { self.editNote = true }) {
                        Image(systemName: "pencil")
                    }
                    Button(action: { self.showAlert = true }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        )
        .navigationBarTitle("", displayMode: .inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
    func likeNote() {
        print("Like note")
    }
    
    func shareOnFeed() {
        
        
        
        print("Share note to feed")
    }
    
    func shareOnOtherApps() {
        print("Share note to social")
    }
}
