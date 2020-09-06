//
//  ProfileView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-06.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @State private var name: String = ""
    
    @State private var numPublicNotes: Int32 = 0
    @State private var numNotes: Int32 = 0
    @State private var numFriends: Int32 = 0
    
    
    var body: some View {
        VStack {
            Text(name)
                .font(.system(size: 20))
                .padding(.bottom, 50)
            HStack {
                VStack {
                    Text("Friends")
                        .font(.system(size: 13))
                        .opacity(0.8)
                    Text("\(numFriends)")
                        .font(.system(size: 26))
                }
                Spacer()
                VStack {
                    Text("Notes")
                        .font(.system(size: 13))
                        .opacity(0.8)
                    Text("\(numNotes)")
                        .font(.system(size: 26))
                }
                Spacer()
                VStack {
                    Text("Public Notes")
                        .font(.system(size: 13))
                        .opacity(0.8)
                    Text("\(numPublicNotes)")
                        .font(.system(size: 26))
                }
            }.padding(.bottom, 50)
        }.onAppear {
            if let firebaseUser = Auth.auth().currentUser {
                self.name = firebaseUser.displayName!
            }
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
