//
//  Recipe.swift
//  Christmasville
//
//  Created by Mike on 9/17/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Recipe: Codable, Hashable {
    @DocumentID var id: String?
    var title: String
    var ingredients: String
    var instructions: String
    var tip: String?
}
