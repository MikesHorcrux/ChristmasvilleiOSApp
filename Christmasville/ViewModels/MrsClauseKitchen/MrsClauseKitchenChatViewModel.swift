//
//  MrsClauseKitchenChatViewModel.swift
//  Christmasville
//
//  Created by Mike on 8/14/23.
//

import Foundation
import Observation
import FirebaseAuth
import FirebaseFirestore

@Observable
class MrsClauseKitchenChatViewModel {
    var client: APIClient
    var chat: [Message] = []
    var textEntry: String = ""

    private var user: User?
    private let db = Firestore.firestore()
    
    init(client: APIClient) {
        self.client = client
        if let currentUser = Auth.auth().currentUser {
            self.user = currentUser
            fetchUserToken()
        } else {
            self.user = nil
        }
    }
    
    private func fetchUserToken() {
        user?.getIDToken(completion: { token, error in
            if let error = error {
                print("Error fetching user token: \(error.localizedDescription)")
            } else if let token = token {
                self.client.assign(accessToken: token)
            }
        })
    }
    
    func sendMsg(){
        var msg = Message(content: textEntry, role: "user")
        chat.append(msg)
        textEntry = ""
        Task{
            await sendConversation()
        }
    }

    private func parseRecipe(from response: String) -> Recipe? {
        let pattern = "\\*\\*Title:\\*\\*\\s*(.+?)(?=\\*\\*Ingredients:\\*\\*)\\*\\*Ingredients:\\*\\*\\s*(.+?)(?=\\*\\*Instructions:\\*\\*)\\*\\*Instructions:\\*\\*\\s*(.+)"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators)
            let nsString = response as NSString
            if let match = regex.firstMatch(in: response, options: [], range: NSRange(location: 0, length: nsString.length)) {
                let title = nsString.substring(with: match.range(at: 1)).trimmingCharacters(in: .whitespacesAndNewlines)
                let ingredients = nsString.substring(with: match.range(at: 2)).trimmingCharacters(in: .whitespacesAndNewlines)
                let instructions = nsString.substring(with: match.range(at: 3)).trimmingCharacters(in: .whitespacesAndNewlines)
                
                return Recipe(title: title, ingredients: ingredients, instructions: instructions)
            }
        } catch {
            print("Invalid regex: \(error.localizedDescription)")
        }
        
        return nil
    }

    
    private func containsTitleOrIngredients(in string: String) -> Bool {
        let lowercasedString = string.lowercased()
        return lowercasedString.contains("title") || lowercasedString.contains("ingredients")
    }
    
    func sendConversation() async {
        do {
            var currentChat: [Message]
            if chat.isEmpty {
                 currentChat = [
                Message(content: "Hey 👋", role: "user")
                ]
            } else {
                currentChat = chat
            }
            var response = try await client.dispatch(MCKChatRequest(conversation: Conversation(messages: chat)))
            self.chat.append(response.messages.first!)
            
            // Try to parse the recipe from the response message
            if containsTitleOrIngredients(in: response.messages.first!.content) {
                if let parsedRecipe = parseRecipe(from: response.messages.first!.content) {
                    await saveMrsClauseRecipe(recipe: parsedRecipe)
                } else {
                    print("Could not parse a recipe from the response")
                }
            }
        } catch {
            print("There is an error")
        }
    }
    
    //firebase
    
    func saveMrsClauseRecipe(recipe: Recipe) async {
        do {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("No user ID found")
                return
            }
            let _ = try await db.collection("christmasRecipes").document(userId).collection("mrsClauseRecipes").addDocument(from: recipe)
        } catch {
            print("Error saving location: \(error)")
        }
    }
}
