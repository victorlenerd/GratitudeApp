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
    @Environment(\.managedObjectContext) var managedContext

    @EnvironmentObject var appState: AppState

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
}

// MARK:- Methods

extension LoginView {
    
    // MARK:- Login
    
    func login() {
        appState.isLoading = true
        
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (authDataResult: AuthDataResult?, error: Error?) in
            
            if let err = error {
                self.alertMessage = err.localizedDescription
                self.showAlert = true
            }
            
            if authDataResult != nil {
                if appState.FCMToken != nil {
                    UsersTokenClient.putUserToken(userID: Auth.auth().currentUser!.uid, FCMToken: appState.FCMToken!) { (error: Error?, feeds: UserToken?) in }
                }
                self.fetchNotes(userID: (authDataResult?.user.uid)!)
            }
            
            appState.isLoading = false
        }
    }
    
    // MARK:- Open Reset Password Screen
    
    func openResetPasswordScreen() {
        self.openResetPassword = true
    }
    
    // MARK:- Validate Text Inputs
    
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
    
    func fetchNotes(userID: String) {
        appState.isLoading = true
        NoteClient.getUserNotes(userID: userID) { (error: Error?, noteContainer: [NoteContainer]?) in
            guard let container = noteContainer else {
                return
            }
                    
            DispatchQueue.main.async {
                for content in container {
                    print("content", content)
                    do {
                        let note = Note(context: managedContext)
                        note.text = content.text
                        note.ownerID = content.ownerID
                        note.uploaded = content.isPublic
                        note.uuid = UUID.init(uuidString: content.uuid)
                        note.createDate = Date()
                        
                        try managedContext.save()
                    } catch {
                        fatalError("Failed to save note" + error.localizedDescription)
                    }
                }

                
                appState.isLoading = false
                appState.isLoggedIn = true
            }
        }
    }
}
