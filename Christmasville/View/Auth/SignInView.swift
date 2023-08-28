//
//  SignInView.swift
//  Christmasville
//
//  Created by Mike on 7/16/23.
//

import SwiftUI
import Observation

struct SignInView: View {
    var authManager: AuthenticationManager
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Sign Up")
                    .font(.largeTitle)
                Spacer()
            }
            
            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray))
                .cornerRadius(8)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray))
                .cornerRadius(8)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(.systemGray))
                .cornerRadius(8)
            
            Button(action: {
                Task {
                    await authManager.createAccount(email: email, password: password)
                }
            }) {
                if authManager.isAuthenticating {
                    ProgressView()
                } else {
                    Text("Sign In")
                }
            }
            .buttonStyle(SantaRedPillButtonStyle())
            .padding(.top, 60)
        }
    }
}

#Preview {
    SignInView(authManager: AuthenticationManager())
}
