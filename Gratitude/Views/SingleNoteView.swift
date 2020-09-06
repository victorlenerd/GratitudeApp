//
//  NoteView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-05.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI

struct SingleNoteView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CreateNoteView()) {
                    Text("Show Detail View")
                }
            }.navigationBarTitle("Notes", displayMode: .large)
        }
    }
}

struct SingleNoteView_Previews: PreviewProvider {
    static var previews: some View {
        SingleNoteView()
    }
}
