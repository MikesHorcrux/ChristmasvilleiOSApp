//
//  LoginView.swift
//  Christmasville
//
//  Created by Mike on 7/16/23.
//

import SwiftUI
import Observation

struct LoginView: View {
    var authManager: AuthenticationManager
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Login")
                    .font(.largeTitle)
                Spacer()
            }
            
            TextField("Email", text: $email)
                .padding()
                .background(.gray)
                .cornerRadius(8)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray))
                .cornerRadius(8)
            
            Button(action: {
                Task{
                    await authManager.signInWithEmail(email: email, password: password)
                }
            }) {
                if authManager.isAuthenticating {
                    ProgressView()
                } else {
                    Text("Login")
                }
            }
            .buttonStyle(SantaRedPillButtonStyle())
            .padding(.top, 60)
        }
    }
}

#Preview {
    
    LoginView(authManager: AuthenticationManager.init())
}
