//
//  ChristmasvilleApp.swift
//  Christmasville
//
//  Created by Mike on 6/10/23.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct ChristmasvilleApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
           MainView()
                .modelContainer(for: [Recipe.self, ChristmasLightsLocation.self, Giftee.self])
        }
    }
}
