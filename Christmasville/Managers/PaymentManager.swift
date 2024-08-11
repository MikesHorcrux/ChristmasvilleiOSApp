////
////  PaymentManager.swift
////  Christmasville
////
////  Created by Mike  Van Amburg on 8/6/24.
////
//
//import Foundation
//import RevenueCat
//
//class PaymentManager: ObservableObject {
//    static let shared = PaymentManager()
//    
//    @Published var presentPaywall: Bool = false
//    @Published var hasAccess: Bool = false
//    @Published var isPaidUserAfterTrial = false
//    
//    init() {
//        Task {
//            await checkPayments()
//            try await listenForUpdates()
//        }
//    }
//    
//    @MainActor
//    func checkPayments() async {
//        do {
//            let customerInfo = try await Purchases.shared.customerInfo()
//            
//            if customerInfo.entitlements.active.isEmpty {
//                hasAccess = false
//            } else {
//                hasAccess = true
//                if customerInfo.entitlements.active.first?.value.periodType == .normal {
//                    isPaidUserAfterTrial = true
//                }
//            }
//        } catch {
//            print(error.localizedDescription)
//            hasAccess = false
//        }
//    }
//    
//    @MainActor
//    func listenForUpdates() async throws {
//        for try await customerInfo in Purchases.shared.customerInfoStream {
//            if customerInfo.entitlements.active.isEmpty {
//                hasAccess = false
//            } else {
//                hasAccess = true
//                print(customerInfo.entitlements.active.isEmpty.description)
//            }
//        }
//    }
//}
