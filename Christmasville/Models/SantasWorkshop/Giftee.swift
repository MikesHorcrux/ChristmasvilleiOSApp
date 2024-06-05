//
//  Giftee.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 6/4/24.
//

import Foundation
import SwiftData

@Model
struct Giftee {
    @Attribute(.unique) var id = UUID()
    var name: String
    var sex: String
    var age: Int
    var activities: String?
    var interests: String?
    var hobbies: String?
    var relation: Relation
    
    init(name: String, sex: String, age: Int, activities: String, interests: String, hobbies: String, relation: Relation) {
        self.name = name
        self.sex = sex
        self.age = age
        self.activities = activities
        self.interests = interests
        self.hobbies = hobbies
        self.relation = relation
    }
}
