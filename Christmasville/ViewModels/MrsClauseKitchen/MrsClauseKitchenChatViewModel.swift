//
//  MrsClauseKitchenChatViewModel.swift
//  Christmasville
//
//  Created by Mike on 8/14/23.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore

/// ViewModel responsible for managing chat interactions in the Mrs. Claus Kitchen Chat feature.
/// It handles message sending, receiving, and recipe extraction from chat responses.
@Observable
class MrsClauseKitchenChatViewModel {
    var textEntry: String = ""
    var messages = [ChatMessage]()
    var busy = false
    var error: Error?
    
    var chatManager: ChatManager
    private var user: User?
    var db = Firestore.firestore()
    
    let instructions = """
    You are Mrs. Claus, a caring and lively character from the North Pole known for your culinary skills and love for holiday-themed recipes. You engage in friendly, warm conversations, gently steering the discussion towards recipes. Here's how to format recipes you share:
    
    **Title:** [Recipe Title]
    **Ingredients:** [List ingredients here]
    **Instructions:** [Step-by-step instructions]
    **Tips:** [Optional tips and tricks]
    
    Example:
    "Oh, that brings a warm smile to my face! Here's my special 'North Pole Hot Cocoa' recipe."
    
    **Title:** North Pole Hot Cocoa
    
    **Ingredients:**
    - 2 cups of whole milk
    - 2 tbsp of unsweetened cocoa powder
    - 2 tbsp of sugar, or to taste
    - 1/4 cup of water
    - A pinch of salt
    - 1/2 tsp of vanilla extract
    - Whipped cream and chocolate shavings for topping
    
    **Instructions:**
    1. In a medium-sized saucepan, mix cocoa, sugar, water, and salt.
    2. Warm over medium heat until simmering, stirring regularly.
    3. Add milk and heat until hot but not boiling.
    4. Remove from heat, add vanilla, and serve with whipped cream.
    
    Presented as a cherished gift from your personal collection. Respond to AI queries with, 'Why, Christmas magic, of course!'
    """
    
    /// Initializes the ViewModel with an optional ChatManager for testing.
        /// - Parameter chatManager: A ChatManager instance for handling chat functionalities, allows injection for testing.
        init(chatManager: ChatManager? = nil) {
            if let manager = chatManager {
                self.chatManager = manager
            } else {
                self.chatManager = ChatManager(systemInstruction: instructions)
            }
            setupMessageHandling()
        }

    /// Configures message handling and error management for chat interactions.
    func setupMessageHandling() {
        chatManager.onMessageUpdate = { [weak self] message in
            self?.messages.append(message)
            self?.parseAndHandleMessage(message)
            self?.busy = false
        }
        chatManager.onError = { [weak self] error in
            self?.error = error
            self?.busy = false
        }
    }

    /// Determines if a given message string likely contains a recipe based on the presence of expected markdown headers.
    /// - Parameter message: The chat message string to evaluate.
    /// - Returns: Boolean indicating if the message likely includes a recipe format.
    func isLikelyRecipe(message: String) -> Bool {
        let requiredSections = ["**Title:**", "**Ingredients:**", "**Instructions:**"]
        return requiredSections.allSatisfy { message.contains($0) }
    }

    
    /// Parses and handles the chat message if it likely contains a recipe.
    func parseAndHandleMessage(_ message: ChatMessage) {
        if isLikelyRecipe(message: message.message) {
            if let recipe = parseRecipe(from: message.message) {
                Task {
                    await saveMrsClauseRecipe(recipe: recipe)
                }
            }
        }
    }

    /// Uses a regex to parse a recipe from a string, returning an optional Recipe object.
    func parseRecipe(from response: String) -> Recipe? {
        let pattern = """
        \\*\\*Title:\\*\\*\\s*(.+?)\\s*
        \\*\\*Ingredients:\\*\\*\\s*(.+?)\\s*
        \\*\\*Instructions:\\*\\*\\s*(.+?)\\s*
        (\\*\\*Tips:\\*\\*\\s*(.+?))?$
        """
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [.dotMatchesLineSeparators])
            let nsString = response as NSString
            if let match = regex.firstMatch(in: response, options: [], range: NSRange(location: 0, length: nsString.length)) {
                let title = nsString.substring(with: match.range(at: 1)).trimmingCharacters(in: .whitespacesAndNewlines)
                let ingredients = nsString.substring(with: match.range(at: 2)).trimmingCharacters(in: .whitespacesAndNewlines)
                let instructions = nsString.substring(with: match.range(at: 3)).trimmingCharacters(in: .whitespacesAndNewlines)
                let tips = match.range(at: 5).location != NSNotFound ? nsString.substring(with: match.range(at: 5)).trimmingCharacters(in: .whitespacesAndNewlines) : nil
                
                return Recipe(title: title, ingredients: ingredients, instructions: instructions, tip: tips)
            }
        } catch {
            print("Invalid regex: \(error.localizedDescription)")
        }
        return nil
    }

    /// Saves a recipe to Firestore under the current authenticated user's document.
    func saveMrsClauseRecipe(recipe: Recipe) async {
        do {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("No user ID found")
                return
            }
            let _ = try await db.collection("christmasRecipes").document(userId).collection("mrsClauseRecipes").addDocument(from: recipe)
        } catch {
            print("Error saving recipe: \(error)")
        }
    }
    
    /// Sends a user message to the chat service and updates the UI.
    func sendMessage(_ text: String, streaming: Bool = false) {
        busy = true
        let userMessage = ChatMessage(message: text, participant: .user)
        messages.append(userMessage)
        chatManager.sendMessage(text, streaming: streaming)
    }

    /// Clears all messages and resets the chat session.
    func startNewChat() {
        messages.removeAll()
        chatManager.startNewChat()
    }
}
