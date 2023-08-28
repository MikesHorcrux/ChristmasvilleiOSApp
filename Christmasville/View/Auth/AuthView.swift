//
//  AuthView.swift
//  Christmasville
//
//  Created by Mike on 7/16/23.
//

import SwiftUI
import Observation
import AuthenticationServices

struct AuthView: View {
    var authManager: AuthenticationManager = AuthenticationManager()
    @State var showSheet: Bool = false
    var body: some View {
        ZStack {
            //#if os(iOS)
            Image("roberto-nickson-5PQn41LFsQk-unsplash")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(edges: .all)
//            #else
//            RepeatingPlayer()
//                            .edgesIgnoringSafeArea(.all)
//            #endif
            
            VStack{
               viewContent
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .sheet(isPresented: $showSheet) {
            EmailSignUpView(authManager: authManager)
        }
    }
    
    private var viewContent: some View {
        VStack{
            Spacer()
            Button("Continue with Email") {
                showSheet.toggle()
            }
            .buttonStyle(SantaRedPillButtonStyle())
            #if os(iOS)
            SignInWithAppleButton { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authorization):
                    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                        Task {
                            await authManager.authorizationController(controller: nil, didCompleteWithAuthorization: authorization)
                        }
                    }
                case .failure(let error):
                    authManager.error = error
                }
            }
            .frame(maxWidth: 300, maxHeight: 50)
            .padding(.top, 16)
            #endif
        }
        .padding(.bottom, 50)
    }
}


#Preview {
    AuthView()
}
