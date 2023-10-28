//
//  MainView.swift
//  Christmasville
//
//  Created by Mike on 6/11/23.
//

import SwiftUI
import Observation

struct MainView: View {
    @Environment(\.apiClient) var apiClient: APIClient
    @State var auth = AuthenticationManager()
    
    var body: some View {
        if auth.user != nil {
                CVTabView()
        } else {
            AuthView(authManager: auth)
        }
    }
}

#Preview {
    MainView()
}
