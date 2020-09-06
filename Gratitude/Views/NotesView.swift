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
                List(notes, id: \.self) { (note: Note) in
                    NavigationLink(destination: SingleNoteView(note: note)) {
                        VStack(alignment: .leading) {
                            Text("\((note.createDate?.description(with: Locale(identifier: "en_US")))!)")
                                .font(.system(size: 12))
                                .opacity(0.6)
                            Text("\(note.text!.prefix(10).description)")
                                .padding(.top, 20)
                        }
                    }
                }
            }.navigationBarTitle("Notes", displayMode: .large)
            .navigationBarItems(trailing:
               NavigationLink(destination: CreateNoteView()) {
                   Text("Create Note")
               }
           )
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
