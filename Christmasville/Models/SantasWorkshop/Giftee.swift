//
//  Giftee.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 6/4/24.
//

import Foundation
import SwiftData

@Model
class Giftee {
    var name: String
    var sex: String
    var age: String
    var activities: String
    var interests: String
    var hobbies: String
    var relation: Relation
    var giftStatus: GiftStatus
    var trackingNumber: String?
    
    init(name: String, sex: String, age: String, activities: String = "", interests: String = "", hobbies: String = "", relation: Relation, giftStatus: GiftStatus = .none, trackingNumber: String? = nil) {
        self.name = name
        self.sex = sex
        self.age = age
        self.activities = activities
        self.interests = interests
        self.hobbies = hobbies
        self.relation = relation
        self.giftStatus = giftStatus
        self.trackingNumber = trackingNumber
    }
}

