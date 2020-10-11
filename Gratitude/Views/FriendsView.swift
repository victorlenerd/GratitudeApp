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
    @State private var friends: [FriendContainer] = []
    
    @State private var userID: String = ""
    
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    ZStack {
                        HStack {
                            TextField("Type an email to find a friend", text: $searchText)
                                .autocapitalization(.none)
                                .font(.system(size: 12, weight: .light))
                                .padding(EdgeInsets(top: 8, leading: 30, bottom: 8, trailing: 10))
                                .background(Color.black.opacity(0.1))
                                .cornerRadius(20)
                            if self.emailPredicate.evaluate(with: self.searchText) && !self.isSearchingForFriend {
                                Button("Search", action: searchByEmail)
                            }
                        }
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .opacity(0.5)
                                .padding(.leading, 10)
                            Spacer()
                        }
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
                .padding(.leading)
                .padding(.trailing)
                .disabled(appState.isLoading!)
                if !isSearchingForFriend {
                    VStack {
                        if friends.count > 0 {
                            List {
                                ForEach(self.friends, id: \.self) { (friend: FriendContainer) in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(friend.info.DisplayName)
                                            Text(friend.info.Email)
                                                .font(.system(size: 10, weight: .light))
                                        }
                                        .padding(.top, 10)
                                        .padding(.bottom, 10)
                                        Spacer()
                                        if friend.request.status == FriendRequestStatus.Pending.rawValue && friend.request.userID == userID {
                                            Group {
                                                Button(action: { self.deleteFriendRequest(friendContainer: friend) }) {
                                                    Text("Delete")
                                                        .font(.system(size: 12, weight: .light))
                                                        .foregroundColor(Color.red)
                                                }
                                                .padding(.trailing, 20)
                                                Button(action: { self.approveFriendRequest(friendContainer: friend) }) {
                                                    Text("Approve")
                                                        .font(.system(size: 12, weight: .light))
                                                        .foregroundColor(Color.white)
                                                }
                                                .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                                                .background(Color.blue)
                                                .cornerRadius(5)
                                            }
                                        }
                                        
                                        if friend.request.status == FriendRequestStatus.Pending.rawValue && friend.request.userID != userID {
                                            Text("Pending")
                                                .padding(.all, 5)
                                                .background(Color.black.opacity(0.1))
                                                .font(.system(size: 12, weight: .light))
                                                .foregroundColor(Color.black)
                                                .cornerRadius(5)
                                        }
                                        
                                        if friend.request.status == FriendRequestStatus.Approved.rawValue {
                                            Button(action: { self.deleteFriendRequest(friendContainer: friend) }) {
                                                Text("Delete")
                                                    .font(.system(size: 12, weight: .light))
                                                    .foregroundColor(Color.red)
                                            }
                                            .padding(.trailing, 20)
                                        }
                                    }
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .listStyle(PlainListStyle())
                        } else {
                            Text("You don't have any friends yet!")
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .opacity(0.5)
                                .padding(.leading, 50)
                                .padding(.trailing, 50)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if (self.friendInfo != nil) {
                    VStack {
                        Text(self.friendInfo?.DisplayName ?? "")
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        Text(self.friendInfo?.Email ?? "")
                            .fontWeight(.light)
                            .padding(.bottom, 50)
                        Button("Add Friend", action: sendFriendRequest)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack {
                        EmptyView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .alert(isPresented: self.$showSearchAlert) {
                Alert(
                    title: Text(self.alertTitle),
                    message: Text(self.alertMessage),
                    dismissButton: .default(Text("OK"), action: {
                        self.isSearchingForFriend = false
                        self.searchText = ""
                        self.friendInfo = nil
                        self.fetchRequest()
                    })
                )
            }
            .onAppear() {
                self.userID = Auth.auth().currentUser?.uid ?? ""
                self.fetchRequest()
            }
            .navigationBarTitle("Friends", displayMode: .large)
            .navigationBarItems(trailing: Button(action: self.fetchRequest) {
                Text("Reload")
                Image(systemName: "arrow.clockwise")
            })
            .padding()
        }
    }

}

// MARK:- Methods

extension FriendsView {
    
    // MARK: - Search For Friends By Email
    
    func searchByEmail() {
        appState.isLoading = true
        self.isSearchingForFriend = true
        FriendClient.searchByEmail(email: self.searchText) { (_ error: Error?, _ friend: FriendInfo?) in
            DispatchQueue.main.async {
                if let err = error {
                    appState.isLoading = false
                    self.alertTitle = "Error"
                    self.alertMessage = err.localizedDescription
                    self.showSearchAlert = true
                    return
                }
                
                if let ff = friend {
                    self.appState.isLoading = false
                    self.friendInfo = ff
                }
            }
        }
    }
    
    // MARK: - Send Friend Request
    
    func sendFriendRequest() {
        let sentRequest = friends.filter { (friend: FriendContainer) -> Bool in
            if friend.request.status == FriendRequestStatus.Pending.rawValue && friend.info.UID == self.friendInfo?.UID {
                return true
            }
            
            return false
        }
        
        if !sentRequest.isEmpty {
            self.alertTitle = "Error"
            self.alertMessage = "You already sent a request to this \(self.friendInfo?.DisplayName ?? "")"
            self.showSearchAlert = true
            return
        }
        
        appState.isLoading = true
        
        FriendClient.createFriendRequest(ownerID: Auth.auth().currentUser?.uid ?? "", friendInfo: self.friendInfo!) { (error: Error?, friendRequest: FriendRequest?) in
            DispatchQueue.main.async {
                if let err = error {
                    appState.isLoading = false
                    self.alertTitle = "Error"
                    self.alertMessage = err.localizedDescription
                    self.showSearchAlert = true
                    return
                }
                
                appState.isLoading = false
                self.alertTitle = "Success"
                self.alertMessage = "Successfully sent friend request to \(self.friendInfo?.DisplayName ?? "")"
                self.showSearchAlert = true
            }
        }
    }
    
    // MARK: - Approve Friend Request
    
    func approveFriendRequest(friendContainer: FriendContainer) {
        appState.isLoading = true
        FriendClient.approveFriendRequest(friendRequest: friendContainer.request) { (error: Error?, _: FriendRequest?) in
            DispatchQueue.main.async {
                if let err = error {
                    print("err", err)
                    appState.isLoading = false
                    self.alertTitle = "Error"
                    self.alertMessage = err.localizedDescription
                    self.showSearchAlert = true
                    return
                }
                
                appState.isLoading = false
                self.fetchRequest()
            }
        }
    }
    
    // MARK: - Delete Friend Request
    
    func deleteFriendRequest(friendContainer: FriendContainer) {
        appState.isLoading = true
        FriendClient.deleteFriend(uuid: friendContainer.request.uuid) { (error: Error?, _) in
            DispatchQueue.main.async {
                if let err = error {
                    self.alertTitle = "Error"
                    self.alertMessage = err.localizedDescription
                    self.showSearchAlert = true
                    return
                }
                
                appState.isLoading = false
                self.fetchRequest()
            }
        }
    }
    
    // MARK: - Fetch All Friends Data
    
    func fetchRequest() {
        appState.isLoading = true
        FriendClient.getUserFriends(userID: Auth.auth().currentUser?.uid ?? "") { (_ error: Error?, _ friends: [FriendContainer]?) in
            DispatchQueue.main.sync {
                appState.isLoading = false
                if let err = error {
                    self.alertTitle = "Error"
                    self.alertMessage = err.localizedDescription
                    self.showSearchAlert = true
                    return
                }
                
                self.friends = []
                self.friends = friends ?? []
            }
        }
    }
    
}
