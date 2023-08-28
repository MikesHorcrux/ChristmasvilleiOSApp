//
//  CLMViewModel.swift
//  Christmasville
//
//  Created by Mike on 7/31/23.
//

import Foundation
import Observation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

@Observable
class CLMViewModel {
    var clLocations: [ChristmasLightsLocation] = []
    var selectedLocation: ChristmasLightsLocation?
    
    func getUserSavedLocations() async {
        do {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("No user ID found")
                return
            }
            let db = Firestore.firestore()
            let snapshot = try await db.collection("christmasLightsLocations").document(userId).collection("SavedLocations").getDocuments()
            
            self.clLocations = snapshot.documents.compactMap { document in
                do {
                    return try document.data(as: ChristmasLightsLocation.self)
                } catch {
                    print("Error decoding document data: \(error)")
                    return nil
                }
            }
        } catch {
            print("Error getting user saved locations: \(error)")
        }
    }
    
    func getAllSavedLocations() async {
        do {
            let db = Firestore.firestore()
            let snapshot = try await db.collection("christmasLightsLocations").getDocuments()

            var allLocations = [ChristmasLightsLocation]()
            
            try await withThrowingTaskGroup(of: [ChristmasLightsLocation].self) { group in
                for document in snapshot.documents {
                    group.addTask {
                        let locationSnapshot = try await document.reference.collection("SavedLocations").getDocuments()
                        let locations: [ChristmasLightsLocation] = locationSnapshot.documents.compactMap { document in
                            do {
                                return try document.data(as: ChristmasLightsLocation.self)
                            } catch {
                                print("Error decoding document data: \(error)")
                                return nil
                            }
                        }
                        return locations
                    }
                }
                
                for try await locations in group {
                    allLocations.append(contentsOf: locations)
                }
            }
            
            self.clLocations = allLocations
        } catch {
            print("Error getting all saved locations: \(error)")
        }
    }
}
