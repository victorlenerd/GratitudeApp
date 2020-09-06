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

    @State private var isNoteOwner: Bool = false
    @State private var noteIsPublic: Bool = false
    
    @ObservedObject var note: Note
    
    var body: some View {
        NavigationView {
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
                
                if self.isNoteOwner == true {
                    Group {
                        Divider()
                        Toggle(isOn: $noteIsPublic) {
                            Text("Make This Note Public")
                                .font(.system(size: 12))
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing:
            NavigationLink(destination: ModifyNoteView(note: note)) {
                if isNoteOwner {
                    Text("Edit Note")
                }
            }
        )
        .onAppear() {
//            if let currentUser = Auth.auth().currentUser {
//                if self.note.ownerID! == currentUser.uid {
//                    self.isNoteOwner = true
//                }
//            }
//
//            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "uuid = %@", self.note.uuid!.uuidString)
//
//            do {
//                let note = try self.managedContext.fetch(fetchRequest)
//                print(note[0].text!)
//            } catch {
//                fatalError("Error occured while trying to get: \(error.localizedDescription)")
//            }
//
//            print("...appearing")

        }
    }
    
    func likeNote() {
        print("Like note")
    }
    
}

//
//struct SingleNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleNoteView()
//    }
//}
