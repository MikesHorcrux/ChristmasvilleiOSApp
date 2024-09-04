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
    
    @AppStorage("hasOnboarded") var hasOnboarded: Bool = false
    @State var subscriptions: SubscriptionManager = .shared
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if !hasOnboarded {
                OnboardingView(hasOnboarded: $hasOnboarded)
            } else {
                MainView(subscriptions: subscriptions)
                 .environment(subscriptions)
                 .modelContainer(for: [Recipe.self, ChristmasLightsLocation.self, Giftee.self])
            }
        }
    }
}
