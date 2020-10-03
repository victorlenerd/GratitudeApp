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
    
    @State private var currentUserID: String = ""
    @State private var feeds: [FeedContainer] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(feeds, id: \.self) { (feed: FeedContainer) in
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
            }.listStyle(GroupedListStyle())
            .navigationBarTitle("Feed", displayMode: .large)
        }.onAppear() {
            self.currentUserID = Auth.auth().currentUser?.uid ?? ""
            self.fetchFeeds()
        }
    }
}


extension FeedView {
    
    func fetchFeeds() {
        FeedsClient.getUserFeeds(userID: self.currentUserID) { (error: Error?, feeds: [FeedContainer]?) in
            if let err = error {
                print(err)
                return
            }
            
            self.feeds = feeds!
        }
    }
    
    func getDate(isoDate: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)
    
        print("isoDate", isoDate)
        
        return date?.timeAgoDisplay() ?? ""
    }
    
}
