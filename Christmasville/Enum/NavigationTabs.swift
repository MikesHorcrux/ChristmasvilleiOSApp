//
//  Tabs.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 6/12/24.
//

import Foundation

enum Tabs: Equatable, Hashable, Identifiable {
    case home
    case lightsMap
    case cookbook
    case santasList
    case northPoleIPhone
    case northPole(Bots)
    
    var id: Int {
        switch self {
        case .home:
            return 0001
        case .lightsMap:
            return 0002
        case .cookbook:
            return 0003
        case .santasList:
            return 0004
        case .northPoleIPhone:
            return 0005
        case .northPole(let bots):
            return bots.id
        }
    }
}


