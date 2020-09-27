//
//  ShareDialog.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-25.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation
import SwiftUI

struct ShareDialog: UIViewControllerRepresentable {
    
    var text: String
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: [text],
                                                              applicationActivities: nil)
        
        
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
    
}
