//
//  FeedNoteView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-10-03.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI

struct FeedNoteView: View {
    
    @State var note: NoteContainer?
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                Text(note!.text)
            }.padding(.top, 25)
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}
