//
//  GiftStatus.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 6/17/24.
//

import Foundation

enum GiftStatus: String, CaseIterable, Codable {
    case none
    case wishlist
    case shopping
    case purchased
    case shipped
    case wrapped
    case given

    var description: String {
        switch self {
        case .none:
            return "No gift status available."
        case .wishlist:
            return "Gift is on the wishlist."
        case .shopping:
            return "Currently shopping for the gift."
        case .purchased:
            return "The gift has been purchased."
        case .shipped:
            return "The gift has been shipped."
        case .wrapped:
            return "The gift has been wrapped."
        case .given:
            return "The gift has been given."
        }
    }
}
