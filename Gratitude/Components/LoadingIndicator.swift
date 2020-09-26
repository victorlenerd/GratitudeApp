//
//  LoadingIndicator.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-23.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation
import SwiftUI


struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool

    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
