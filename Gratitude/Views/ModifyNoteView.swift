//
//  ModifyNoteView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-05.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI

struct ModifyNoteView: View {
    @Environment(\.managedObjectContext) var managedContext

    @State private var text = ""
    @State private var textStyle = UIFont.TextStyle.body
    
    @ObservedObject var note: Note
    
    var body: some View {
        VStack {
            TextView(text: $text, textStyle: $textStyle)
        }
        .padding()
        .onAppear() {
            self.text = self.note.text ?? ""
        }.onDisappear() {
            do {
                self.note.text = self.text
                try self.note.managedObjectContext?.save()
            } catch {
                fatalError("Failed to save note: \(error.localizedDescription)")
            }
        }
    }
}
