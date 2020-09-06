//
//  ForgotPasswordView.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-05.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    
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
            }
        }
    }
    
    func resetPassword() {}
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
