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
    @State private var showShareAlert: Bool = false
    @State private var showErrorAlert: Bool = false
    @State private var showShareSheet: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertText: String = ""
    
    @ObservedObject var note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
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
        .sheet(isPresented: $showShareSheet) {
            ShareDialog(text: note.text!)
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text(self.alertTitle),
                message: Text(self.alertText),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                if isNoteOwner {
                    Button(action: { self.editNote = true }) {
                        Image(systemName: "pencil")
                    }
                    Button(action: {
                        if note.uploaded {
                            self.showShareSheet = true
                        } else {
                            self.showShareAlert = true
                        }
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .alert(isPresented: $showShareAlert) {
                        Alert(
                            title: Text("Share Note"),
                            message: Text("You're about to share your note with friends"),
                            primaryButton: .default(Text("Share On Feed"), action: shareOnFeed),
                            secondaryButton: .default(Text("Share On Others"), action: shareOnOtherApps)
                        )
                    }
                }
            }
        )
        .navigationBarTitle("", displayMode: .inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
}

// MARK:- Methods

extension SingleNoteView {
    
    // MARK:- Share Note On Feed
    
    func shareOnFeed() {
        appState.isLoading = true
        
        if !appState.isOnline! {
            self.alertTitle = "Error"
            self.alertText = "Cannot share note to feed when you're offline"
            self.showErrorAlert = true
            appState.isLoading = false
            return
        }
        
        NoteClient.putNote(note: note) { (error: Error?, note: NoteContainer?) in
            DispatchQueue.main.async {
                if let err = error {
                    self.alertTitle = "Error"
                    self.alertText = err.localizedDescription
                    self.showErrorAlert = true
                    appState.isLoading = false
                    return
                }
                    
                self.note.uploaded = true
                
                do {
                    try managedContext.save()
                } catch {
                    fatalError("Error occured while trying to upload note \(error.localizedDescription)")
                }
                
                self.alertTitle = "Success"
                self.alertText = "Note shared on feed"
                appState.isLoading = false
                self.showErrorAlert = true
            }
        }
    }
    
    // MARK:- Share Note On Other Notes
    
    func shareOnOtherApps() {
        self.showShareAlert = true
    }
    
}
