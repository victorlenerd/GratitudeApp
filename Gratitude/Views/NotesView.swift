//
//  NotesView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-05.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI

struct NotesView: View {
    @FetchRequest(
        entity: Note.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Note.updateDate, ascending: false)
        ]
    ) var notes: FetchedResults<Note>

    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CreateNoteView()) {
                    Text("Create Note")
                }
            }.navigationBarTitle("Notes", displayMode: .large)
        }.onAppear() {
            print(self.notes.count)
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
