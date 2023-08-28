//
//  Address.swift
//  Christmasville
//
//  Created by Mike on 7/8/23.
//

import Foundation

struct Address: Codable {
    var id: UUID = UUID()
    var street: String
    var city: String
    var state: String
    var country: String
    var postalCode: String
}
