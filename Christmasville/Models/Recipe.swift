//
//  Recipe.swift
//  Christmasville
//
//  Created by Mike on 9/17/23.
//

import Foundation

struct Recipe: Codable, Hashable {
    var title: String
    var ingredients: String
    var instructions: String
    var tip: String?
}
