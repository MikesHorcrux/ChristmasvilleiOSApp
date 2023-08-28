//
//  CLMFormViewModel.swift
//  Christmasville
//
//  Created by Mike on 7/8/23.
//

import Foundation
import Observation
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

@Observable
class CLMFormViewModel {
    var coordinates: Coordinates = Coordinates(latitude: 0, longitude: 0)
    var houseType: ChristmasLightsHouseType = .amazing
    var nickName: String = ""
    var address: Address = Address(street: "", city: "", state: "", country: "", postalCode: "")
    
    let db = Firestore.firestore()
    
    func save() async {
        do {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("No user ID found")
                return
            }
            let location = ChristmasLightsLocation(nickname: nickName, address: address, coordinates: coordinates, houseType: houseType)
            let _ = try await db.collection("christmasLightsLocations").document(userId).collection("SavedLocations").addDocument(from: location)
        } catch {
            print("Error saving location: \(error)")
        }
    }
}

