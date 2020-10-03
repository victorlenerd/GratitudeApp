//
//  ContentView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-08-31.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var selection = 2

    @ViewBuilder var body: some View {
        ZStack {
            VStack {
                if !appState.isOnline! {
                    Text("OFFLINE")
                }
                
                if appState.isLoggedIn! {
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
                    }.onAppear() {
                        print(appState)
                    }
                } else {
                    CreateAccountView()
                }
            }.disabled(appState.isLoading!)
            
            if appState.isLoading! {
                VStack {
                    ActivityIndicator(isAnimating: .constant(true))
                }
            }
        }
    }
}
