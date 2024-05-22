//
//  ChristmasLightsLocation.swift
//  Christmasville
//
//  Created by Mike on 7/2/23.
//

import Foundation
import SwiftData

@Model
class ChristmasLightsLocation {
    var id: UUID
    var nickname: String?
    var address: Address
    var coordinates: Coordinates
    var houseType: ChristmasLightsHouseType
    
    init(id: UUID = UUID(), nickname: String? = nil, address: Address, coordinates: Coordinates, houseType: ChristmasLightsHouseType) {
        self.id = id
        self.nickname = nickname
        self.address = address
        self.coordinates = coordinates
        self.houseType = houseType
    }
}
