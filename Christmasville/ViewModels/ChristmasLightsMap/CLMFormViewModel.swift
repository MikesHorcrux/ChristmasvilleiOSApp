//
//  CLMFormViewModel.swift
//  Christmasville
//
//  Created by Mike on 7/8/23.
//

import Foundation
import Observation

@Observable
class CLMFormViewModel {
    var coordinates: Coordinates = Coordinates(latitude: 0, longitude: 0)
    var houseType: ChristmasLightsHouseType = .amazing
    var nickName: String = ""
    var address: Address = Address(street: "", city: "", state: "", country: "", postalCode: "")
    
}

