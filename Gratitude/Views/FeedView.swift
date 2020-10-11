//
//  FeedView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-05.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI
import Firebase

struct FeedView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var currentUserID: String = ""
    @State private var feeds: [FeedContainer] = []
    @State private var numberOfNotes = 0
    
    var body: some View {
        NavigationView {
            VStack {
                if numberOfNotes > 0 {
                    List {
                        ForEach(feeds, id: \.self) { (feed: FeedContainer) in
                            if feed.notes!.count > 0 {
                                Section(header: Text("\(feed.friend.DisplayName)")) {
                                    ForEach(feed.notes!, id: \.self) { (note: NoteContainer) in
                                        NavigationLink(destination: FeedNoteView(note: note)) {
                                            HStack {
                                                Text(self.getDate(isoDate: note.createDate!))
                                                Text("\(note.text)")
                                                    .lineLimit(2)
                                                    .padding(.top, 10)
                                                    .padding(.bottom, 10)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }.listStyle(GroupedListStyle())
                } else {
                    Text("Notes your friends share would show up here")
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .opacity(0.5)
                        .padding(.leading, 50)
                        .padding(.trailing, 50)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("Feed", displayMode: .large)
            .navigationBarItems(trailing: Button(action: self.fetchFeeds) {
                Text("Reload")
                Image(systemName: "arrow.clockwise")
            })
        }
        .onAppear() {
            self.currentUserID = Auth.auth().currentUser?.uid ?? ""
            self.fetchFeeds()
        }
    }
}


extension FeedView {
    
    func fetchFeeds() {
        appState.isLoading = true
        FeedsClient.getUserFeeds(userID: self.currentUserID) { (error: Error?, feeds: [FeedContainer]?) in
            DispatchQueue.main.async {
                appState.isLoading = false
                if let err = error {
                    print(err)
                    return
                }
                
                self.feeds = []
                self.feeds = feeds!
            }
        }
    }
    
    func getDate(isoDate: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)
    
        print("isoDate", isoDate)
        
        return date?.timeAgoDisplay() ?? ""
    }
    
}
