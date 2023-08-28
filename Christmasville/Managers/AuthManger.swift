//
//  AuthManger.swift
//  Christmasville
//
//  Created by Mike on 7/16/23.
//

import Observation
import SwiftUI
import FirebaseAuth
import AuthenticationServices


@Observable
class AuthenticationManager: NSObject{
    var user: User?
    var isAuthenticating = false
    var error: Error?
    
    static let shared = AuthenticationManager()
    private let auth = Auth.auth()
    
    override init() {
        super.init()
        if let user = Auth.auth().currentUser {
            self.user = user
        } else {
            self.user = nil
        }
    }
    
    func signInWithEmail(email: String, password: String) async {
        isAuthenticating = true
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            user = result.user
        } catch {
            self.error = error
            print(error)
        }
        isAuthenticating = false
    }
    
    func createAccount(email: String, password: String) async {
        isAuthenticating = true
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            user = result.user
        } catch {
            self.error = error
        }
        isAuthenticating = false
    }

    func signOut() {
        do {
            try auth.signOut()
        } catch {
            self.error = error
        }
    }
    
    func deleteUser() {
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
            print(error)
          } else {
              self.user = nil
              print("user deleted")
          }
        }
    }
    
}

extension AuthenticationManager: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController?, didCompleteWithAuthorization authorization: ASAuthorization) async {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = String.randomNonce() else {
                fatalError("Invalid nonce")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            isAuthenticating = true
            Task {
                do {
                    let result = try await auth.signIn(with: credential)
                    user = result.user
                } catch {
                    self.error = error
                }
                isAuthenticating = false
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController?, didCompleteWithError error: Error) async {
        self.error = error
    }
}
