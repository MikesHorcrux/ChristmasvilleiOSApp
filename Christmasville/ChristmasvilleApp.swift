//
//  ChristmasvilleApp.swift
//  Christmasville
//
//  Created by Mike on 6/10/23.
//

import SwiftUI
import Firebase

@main
struct ChristmasvilleApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
           MainView()
                .environment(\.apiClient, DefaultAPIClient(baseURL: Env.secret(.apiBaseURL)))

        }
    }
}
