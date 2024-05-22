//
//  ChristmasvilleApp.swift
//  Christmasville
//
//  Created by Mike on 6/10/23.
//

import SwiftUI
import SwiftData

@main
struct ChristmasvilleApp: App {
    
    var body: some Scene {
        WindowGroup {
           MainView()
                .modelContainer(for: [Recipe.self, ChristmasLightsLocation.self])
        }
    }
}
