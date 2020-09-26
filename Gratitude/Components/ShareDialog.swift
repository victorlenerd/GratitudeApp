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
    var callback: () -> Void
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [text],
                                        applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
    
    func makeCoordinator() -> ShareDialogCoordinator {
        return ShareDialogCoordinator()
    }
    
}

class ShareDialogCoordinator {
    
}
