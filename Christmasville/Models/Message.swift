//
//  Message.swift
//  JuC
//
//  Created by Mike on 4/2/23.
//

import Foundation

struct Message: Codable {
    
    var content: String
    var role: String
}

extension Message: Equatable { }
