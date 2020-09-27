//
//  FeedView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-05.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Feeds View")
            }
            .navigationBarTitle("Feed", displayMode: .large)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
