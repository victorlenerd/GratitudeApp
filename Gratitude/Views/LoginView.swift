//
//  SwiftUIView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-04.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Login Account")
                    .bold()
                    .font(.system(size: 22, weight: .light))
                    .padding()
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email")
                    TextField("Enter your email", text: $email)
                        .padding(.bottom, 20)
                    Text("Password")
                    SecureField("Enter your password", text: $password)
                        .padding(.bottom, 100)
                    HStack() {
                        Button("Login", action: login)
                            .padding(16)
                            .background(Color.black)
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(.white)
                            .border(Color.white)
                        Spacer()
                        Button("Forgot Password", action: openResetPasswordScreen)
                    }
                }.padding()
                Spacer()
            }
        }
    }
    
    // MARK:- Login
    
    func login() {}
    
    // MARK:- Open Create Account Screen
    
    func openCreateAccountScreen() {}
    
    // MARK:- Open Reset Password Screen
    func openResetPasswordScreen() {}
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
