//
//  ForgotPasswordView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-05.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    @State private var email: String = ""
    
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Forgot Password")
                    .bold()
                    .font(.system(size: 22, weight: .light))
                    .padding()
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email")
                    TextField("Enter your email", text: $email)
                        .padding(.bottom, 20)
                    HStack() {
                        Button("Reset Password", action: resetPassword)
                            .padding(16)
                            .background(Color.black)
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(.white)
                            .border(Color.white)
                    }
                    Spacer()
                }.padding()
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text(self.alertTitle),
                    message: Text(self.alertMessage),
                    dismissButton: .default(Text("Got it!")))
            }
        }
    }
}

// MARK: - Methods

extension ForgotPasswordView {

    // MARK:- Reset Password
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: self.email) { (error: Error?) in
            if let err = error {
                self.showAlert = true
                self.alertTitle = "Error"
                self.alertMessage = err.localizedDescription
                return
            }
            
            self.showAlert = true
            self.alertTitle = "Success"
            self.alertMessage = "Check your email for a reset password mail"
        }
    }

    
}
