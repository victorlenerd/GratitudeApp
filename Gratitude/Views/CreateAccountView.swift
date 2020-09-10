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
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
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
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.bottom, 20)
                    Text("Password")
                    Text("password should be at least six characters")
                        .font(.system(size: 13))
                        .opacity(0.5)
                    SecureField("Enter your password", text: $password)
                        .padding(.bottom, 100)
                    HStack() {
                        Button("Register", action: createAccount)
                            .padding(16)
                            .background(Color.black)
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(.white)
                            .border(Color.white)
                            .opacity(!validateInputs() ? 0.5 : 1)
                            .disabled(!validateInputs())
                        Spacer()
                        Button("I Already Have An Account", action: openLoginScreen)
                    }
                }.padding()
                Spacer()
                NavigationLink(destination: LoginView(), isActive: $openLoginView){
                  Text("")
                }.hidden()
            }
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text(self.alertTitle),
                message: Text(self.alertMessage),
                dismissButton: .default(Text("Got it!")))
        }
    }
    
    // MARK:- Create Account
    
    func createAccount() {
        Auth.auth().createUser(withEmail: self.email, password: self.password) { (authDataresult: AuthDataResult?, error: Error?) in
            
            if let err = error  {
                self.showAlert = true
                self.alertTitle = "Error"
                self.alertMessage = err.localizedDescription
            }
            
            if let result = authDataresult {
                let changeRequest =  result.user.createProfileChangeRequest()
                changeRequest.displayName = self.name
                changeRequest.commitChanges { (error: Error?) in
                    if let err = error  {
                        self.showAlert = true
                        self.alertTitle = "Error"
                        self.alertMessage = err.localizedDescription
                    }
                    
                    print("User Created@")
                }
            }
            
            
            // TODO:- Navigate to tab view
        }
    }
    
    // MARK:- Open Login Account
    
    func validateInputs() -> Bool {
        if self.name.count < 2 {
            return false
        }
        
        if self.password.count < 6 {
            return false
        }
        
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)

        if !emailPredicate.evaluate(with: self.email) {
            return false
        }

        return true
    }
    
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
