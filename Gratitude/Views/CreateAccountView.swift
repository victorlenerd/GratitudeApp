//
//  CreateAccountView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-04.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI
import Firebase

struct CreateAccountView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var openLoginView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Create New Account")
                    .bold()
                    .font(.system(size: 22, weight: .light))
                    .padding()
                VStack(alignment: .leading, spacing: 10) {
                    Text("Name")
                    TextField("Enter your name", text: $name)
                        .padding(.bottom, 20)
                    Text("Email")
                    TextField("Enter your email", text: $email)
                        .padding(.bottom, 20)
                    Text("Password")
                    SecureField("Enter your password", text: $password)
                        .padding(.bottom, 100)
                    HStack() {
                        Button("Register", action: createAccount)
                            .padding(16)
                            .background(Color.black)
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(.white)
                            .border(Color.white)
                        Spacer()
                        Button("I Already Have An Account", action: openLoginScreen)
                    }
                }.padding()
                Spacer()
                NavigationLink(destination: LoginView(), isActive: $openLoginView){
                  Text("")
                }.hidden()
            }
        }
    }
    
    // MARK:- Create Account
    
    func createAccount() {}
    
    // MARK:- Open Login Account

    func openLoginScreen() {
        self.openLoginView = true
        print("handleSuccessfullLogin")
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
