//
//  ContentView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-08-31.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 2

    var body: some View {
        TabView(selection:$selection) {
            FriendsView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Friends")
            }
            .tag(1)
            FeedView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Feed")
            }
            .tag(2)
            NotesView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Notes")
            }
            .tag(3)
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
            }
            .tag(4)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
