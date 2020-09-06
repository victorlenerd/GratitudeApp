//
//  TextView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-06.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI
import UIKit

struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var textStyle: UIFont.TextStyle

    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()

        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        
        textView.becomeFirstResponder()
        
        textView.delegate = context.coordinator
        
        return textView
        
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
    
}

class Coordinator: NSObject, UITextViewDelegate {
    var text: Binding<String>
 
    init(_ text: Binding<String>) {
        self.text = text
    }
 
    func textViewDidChange(_ textView: UITextView) {
        self.text.wrappedValue = textView.text
    }
}
