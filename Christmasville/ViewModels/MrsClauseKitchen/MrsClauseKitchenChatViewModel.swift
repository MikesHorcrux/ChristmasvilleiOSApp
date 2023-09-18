//
//  MrsClauseKitchenChatViewModel.swift
//  Christmasville
//
//  Created by Mike on 8/14/23.
//

import Foundation
import Observation
import FirebaseAuth

@Observable
class MrsClauseKitchenChatViewModel {
    var client: APIClient
    var chat: [Message] = []
    var textEntry: String = ""

    private var user: User?
    
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
    
    func testing() async {
        do {
            let response = try await client.dispatch(testrequest())
                    // Use the response
                    print(response)
            //print(response)
                } catch {
                    // Handle error
                }
    }
    func sendMsg(){
        var msg = Message(content: textEntry, role: "user")
        chat.append(msg)
        textEntry = ""
        Task{
            await sendConversation()
        }
    }
    func parseRecipe(from response: String) -> Recipe? {
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
    func sendConversation() async {
        do {
            let response = try await client.dispatch(MCKChatRequest(conversation: Conversation(messages: chat)))
            self.chat.append(response.messages.first!)
            print(response.messages.first ?? "________")
            
            let nessage: String? = """
                                                                                                                                                                                                                                                                                                                                                    Oh, how wonderful! A hearty stew is just the ticket to keep warm during those chilly winter nights. Now, let me see. Ah, here we are! This is one of Santa's favorites - Hearty Reindeer Stew. And before you ask – no, we don't use actual reindeer up here! That would be quite scandalous. This recipe calls for beef! Here you go:
                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                    **Title:** Hearty North Pole Beef Stew
                                                                                                                                                                                                                                                                                                                                                    **Ingredients:**
                                                                                                                                                                                                                                                                                                                                                    - 2 lbs of stewing beef
                                                                                                                                                                                                                                                                                                                                                    - 2 tablespoons of olive oil
                                                                                                                                                                                                                                                                                                                                                    - Salt and pepper to taste
                                                                                                                                                                                                                                                                                                                                                    - 1 large onion, chopped
                                                                                                                                                                                                                                                                                                                                                    - 3 cloves garlic, minced
                                                                                                                                                                                                                                                                                                                                                    - 2 tablespoons flour
                                                                                                                                                                                                                                                                                                                                                    - 4 cups beef broth
                                                                                                                                                                                                                                                                                                                                                    - 1 cup red wine, optional (replace with broth if not using)
                                                                                                                                                                                                                                                                                                                                                    - 2 cups diced potatoes
                                                                                                                                                                                                                                                                                                                                                    - 1 cup chopped carrots
                                                                                                                                                                                                                                                                                                                                                    - 3/4 cup peas
                                                                                                                                                                                                                                                                                                                                                    - 2 tablespoons Worcestershire sauce
                                                                                                                                                                                                                                                                                                                                                    - 2 teaspoons rosemary
                                                                                                                                                                                                                                                                                                                                                    - 2 teaspoons thyme

                                                                                                                                                                                                                                                                                                                                                    **Instructions:**
                                                                                                                                                                                                                                                                                                                                                    1. Heat the olive oil over medium-high heat in a large pot. Season the beef with salt and pepper and add it to the pot. Cook until browned on all sides.
                                                                                                                                                                                                                                                                                                                                                    2. Add the onion and garlic to the pot and cook for a few minutes until the onion becomes translucent.
                                                                                                                                                                                                                                                                                                                                                    3. Sprinkle flour over the meat and onions, stir well to coat everything.
                                                                                                                                                                                                                                                                                                                                                    4. Gradually add in the beef broth and wine (if using), making sure to stir well to prevent any lumps from forming.
                                                                                                                                                                                                                                                                                                                                                    5. Add in your potatoes, carrots, peas, Worcestershire sauce, rosemary, and thyme.
                                                                                                                                                                                                                                                                                                                                                    6. Bring your stew to a boil then reduce to a simmer, cover with a lid and let it simmer for about 2 hours.
                                                                                                                                                                                                                                                                                                                                                    7. Check seasoning and add more salt and pepper if needed.

                                                                                                                                                                                                                                                                                                                                                    Best served with warm, crusty bread! I believe you'll enjoy this stew. It warms you right up and has comfort written all over it!

                                                                                                                                                                                                                                                                                                                                                    Oh, and don't forget, dear. All recipes taste better when made with a sprinkle of love and a dash of holiday cheer. Can I assist you with any other holiday recipes?
"""
            
            // Try to parse the recipe from the response message
            if let parsedRecipe = parseRecipe(from: nessage!) {
                print("Recipe parsed successfully:")
                print("Title: \(parsedRecipe.title)")
                print("Ingredients: \(parsedRecipe.ingredients)")
                print("Instructions: \(parsedRecipe.instructions)")
            } else {
                print("Could not parse a recipe from the response")
            }
        } catch {
            print("There is an error")
        }
    }
}



struct testrequest: Request {
    typealias ReturnType = String
    
    var path: String = "test"
    var apiVersion: Int? = nil
    var method: HTTPMethod = .get
    
}
