//
//  SwiftUIView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-04.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var openResetPassword: Bool = false
    @State private var openMainView: Bool = false
    
    @State private var alertTitle: String = "Error"
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false

    var mainViewActiveNotification = Notification.Name("mainActive")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Login Account")
                .bold()
                .font(.system(size: 22, weight: .light))
                .padding()
            VStack(alignment: .leading, spacing: 10) {
                Text("Email")
                TextField("Enter your email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
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
                        .opacity(!validateInputs() ? 0.5 : 1)
                        .disabled(!validateInputs())
                    Spacer()
                    Button("Forgot Password", action: openResetPasswordScreen)
                }
            }.padding()
            Spacer()
            NavigationLink(destination: ForgotPasswordView(), isActive: $openResetPassword){
              Text("")
            }.hidden()
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text(self.alertTitle),
                message: Text(self.alertMessage),
                dismissButton: .default(Text("Got it!")))
        }
    }
    
    // MARK:- Login
    
    func login() {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (authDataResult: AuthDataResult?, error: Error?) in
            
            if let err = error {
                self.alertMessage = err.localizedDescription
                self.showAlert = true
            }
            
            if let result = authDataResult {
                NotificationCenter.default.post(name: mainViewScene, object: nil)
            }
        }
    }
    
    // MARK:- Open Reset Password Screen
    func openResetPasswordScreen() {
        self.openResetPassword = true
    }
    
    func validateInputs() -> Bool {
        if self.password.count < 6 {
            return false
        }
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)

        if !emailPredicate.evaluate(with: self.email) {
            return false
        }

        return true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
