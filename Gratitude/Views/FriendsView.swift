//
//  FriendsView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-05.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

struct FriendsView: View {
    @EnvironmentObject var appState:AppState
    
    @State private var searchText: String = ""
    @State private var isSearchingForFriend: Bool = false
    
    @State private var showSearchAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
        
    @State private var showRequestAlert: Bool = false
    
    @State private var friendInfo: FriendInfo?
    
    @FetchRequest(
        entity: Friend.entity(),
        sortDescriptors: []
    ) var friends: FetchedResults<Friend>
    
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Filter or search by email", text: $searchText)
                        .autocapitalization(.none)
                    if self.emailPredicate.evaluate(with: self.searchText) && !self.isSearchingForFriend {
                        Button("Search", action: searchByEmail)
                    }
                    
                    if self.emailPredicate.evaluate(with: self.searchText)
                        && self.isSearchingForFriend
                        && !appState.isLoading! {
                        Button("Cancel", action: {
                            self.searchText = ""
                            self.isSearchingForFriend = false
                        })
                    }
                }
                .disabled(appState.isLoading!)
                if !isSearchingForFriend {
                    VStack {
                        if friends.count > 0 {
                            List() {
                                
                            }
                        } else {
                            Text("You don't have any friends yet! ;)")
                                .fontWeight(.heavy)
                                .opacity(0.6)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack {
                        Text(self.friendInfo?.DisplayName ?? "")
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        Text(self.friendInfo?.Email ?? "")
                            .fontWeight(.light)
                            .padding(.bottom, 50)
                        Button("Add Friend", action: sendFriendRequest).alert(isPresented: $showRequestAlert) {
                            Alert(
                                title: Text(self.alertTitle),
                                message: Text(self.alertMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                    .alert(isPresented: self.$showSearchAlert) {
                        Alert(
                            title: Text(self.alertTitle),
                            message: Text(self.alertMessage),
                            dismissButton: .default(Text("OK"), action: { self.isSearchingForFriend = false })
                        )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .onAppear() {
                FriendClient.getUserFriends(userID: Auth.auth().currentUser?.uid ?? "") { (_ error: Error?, _ friends: [FriendContainer]?) in
                    if let err = error {
                        self.alertTitle = "Error"
                        self.alertMessage = err.localizedDescription
                        self.showSearchAlert = true
                        return
                    }
                    
                    print(friends)
                }
            }
            .navigationBarTitle("Friends", displayMode: .large)
            .padding()
        }
    }
    
    func searchByEmail() {
        appState.isLoading = true
        self.isSearchingForFriend = true
        FriendClient.searchByEmail(email: self.searchText) { (_ error: Error?, _ friend: FriendInfo?) in
            DispatchQueue.main.async {
                if let err = error {
                    print(error)
                    appState.isLoading = false
                    self.alertTitle = "Error"
                    self.alertMessage = err.localizedDescription
                    self.showSearchAlert = true
                    return
                }
                
                print("friend", friend)
                
                if let ff = friend {
                    self.appState.isLoading = false
                    self.friendInfo = ff
                }
            }
        }
    }
    
    func sendFriendRequest() {
        appState.isLoading = true
        
        FriendClient.createFriendRequest(ownerID: Auth.auth().currentUser?.uid ?? "", friendInfo: self.friendInfo!) { (error: Error?, friendRequest: FriendContainer?) in
            DispatchQueue.main.async {
                if let err = error {
                    self.alertTitle = "Error"
                    self.alertMessage = err.localizedDescription
                    self.showSearchAlert = true
                    self.isSearchingForFriend = false
                    appState.isLoading = false
                    return
                }
                
                self.alertTitle = "Success"
                self.alertMessage = "Successfully sent friend request to \(String(describing: self.friendInfo?.DisplayName))"
                self.showSearchAlert = true
                appState.isLoading = false
            }
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
