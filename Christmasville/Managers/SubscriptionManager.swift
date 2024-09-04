//
//  SubscriptionManager.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 8/6/24.
//

import Foundation
import RevenueCat
import Observation

@Observable
@MainActor
class SubscriptionManager {
    var customerInfo: CustomerInfo?
    var isSubscriptionActive: Bool = false
    var showPaywall: Bool = false

    static let shared = SubscriptionManager()

    private init() {
        configureRevenueCat()
        fetchCustomerInfo()
        observeCustomerInfoUpdates()
    }

    private func configureRevenueCat() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_bgShEoxKoGalbOYImQDRXEBzcQX")
    }

    /// Fetch the latest customer information and update the subscription status
    func fetchCustomerInfo() {
        Purchases.shared.getCustomerInfo { [weak self] (customerInfo, error) in
            if let error = error {
                print("Error fetching customer info: \(error.localizedDescription)")
                return
            }
            self?.updateSubscriptionStatus(with: customerInfo)
        }
    }

    /// Update the subscription status based on the fetched customer information
    private func updateSubscriptionStatus(with customerInfo: CustomerInfo?) {
        self.customerInfo = customerInfo
        if let entitlement = customerInfo?.entitlements["Yearly Subscription"], entitlement.isActive {
            self.isSubscriptionActive = true
            self.showPaywall = false
        } else {
            self.isSubscriptionActive = false
            self.showPaywall = true
        }
    }

    /// Observe customer information updates using Swift Concurrency
    private func observeCustomerInfoUpdates() {
        Task {
            for await updatedCustomerInfo in Purchases.shared.customerInfoStream {
                updateSubscriptionStatus(with: updatedCustomerInfo)
            }
        }
    }

    /// Present the paywall if the subscription is not active
    func presentPaywallIfNeeded() {
        if !isSubscriptionActive {
            // Logic to present paywall goes here
            // For example, you could set a @Published variable to show a SwiftUI sheet
            // or trigger a navigation event in your SwiftUI view hierarchy
        }
    }
}
