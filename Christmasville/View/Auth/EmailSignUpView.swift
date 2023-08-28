//
//  EmailSignUpView.swift
//  Christmasville
//
//  Created by Mike on 7/16/23.
//

import SwiftUI
import Observation

struct EmailSignUpView: View {
    @State private var isSignIn = true
    var authManager: AuthenticationManager
    var body: some View {
        VStack {
            if isSignIn {
                SignInView(authManager: authManager)
            } else {
                LoginView(authManager: authManager)
            }
            Spacer()
            Image("santa with snowball_angle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
            Button(action: {
                isSignIn.toggle()
            }) {
                Text(isSignIn ? "Switch to Login" : "Switch to Sign In")
                    .foregroundColor(Color.everGreen)
                    .fontWeight(.bold)
            }
            .padding(.vertical, 16)
        }
        .padding()
        .background(SnowBackground().ignoresSafeArea(edges: .all))
    }
    
}

#Preview {
    EmailSignUpView(authManager: AuthenticationManager())
}
