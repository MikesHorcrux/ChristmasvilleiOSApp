//
//  ChristmasLightsLocation.swift
//  Christmasville
//
//  Created by Mike on 7/2/23.
//

import Foundation

struct ChristmasLightsLocation: Codable {
    var id: UUID = UUID()
    var nickname: String?
    var address: Address
    var coordinates: Coordinates
    var houseType: ChristmasLightsHouseType
}
