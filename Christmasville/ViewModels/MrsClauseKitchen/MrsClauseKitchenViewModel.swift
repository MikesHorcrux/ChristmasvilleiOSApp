//
//  MrsClauseKitchenViewModel.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 9/23/23.
//

import Foundation
import Observation
import FirebaseAuth
import FirebaseFirestore

@Observable
class MrsClauseKitchenViewModel {
    
    var mrsClauseRecipe: [Recipe] = []
    
    private var user: User?
    private let db = Firestore.firestore()
    
    //firebase
    func getSavedMrsClauseRecipes() async {
        do {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("No user ID found")
                return
            }
            let db = Firestore.firestore()
            let snapshot = try await db.collection("christmasRecipes").document(userId).collection("mrsClauseRecipes").getDocuments()
            
            self.mrsClauseRecipe = snapshot.documents.compactMap { document in
                do {
                    return try document.data(as: Recipe.self)
                } catch {
                    print("Error decoding document data: \(error)")
                    return nil
                }
            }
        } catch {
            print("Error getting user saved locations: \(error)")
        }
    }
}
