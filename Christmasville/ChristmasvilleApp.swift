//
//  ChristmasvilleApp.swift
//  Christmasville
//
//  Created by Mike on 6/10/23.
//

import SwiftUI
import SwiftData
import Firebase
import DeviceCheck
import RevenueCat
import RevenueCatUI

@main
struct ChristmasvilleApp: App {
        
    init() {
        FirebaseApp.configure()
               Purchases.logLevel = .debug
               Purchases.configure(withAPIKey: "appl_bgShEoxKoGalbOYImQDRXEBzcQX")
    }
    
    var body: some Scene {
        WindowGroup {
           MainView()
                .modelContainer(for: [Recipe.self, ChristmasLightsLocation.self, Giftee.self])
        }
    }
}
