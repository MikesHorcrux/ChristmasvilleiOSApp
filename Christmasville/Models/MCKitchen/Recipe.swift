//
//  Recipe.swift
//  Christmasville
//
//  Created by Mike on 9/17/23.
//

import Foundation
import SwiftData

@Model
class Recipe {
    
    @Attribute(.unique) var title: String
    var ingredients: String
    var instructions: String
    var tip: String?
    
    init(title: String, ingredients: String, instructions: String, tip: String? = nil) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
        self.tip = tip
    }
}

extension Recipe {
    
    /// Determines if a given message string likely contains a recipe based on the presence of expected markdown headers.
    /// - Parameter message: The chat message string to evaluate.
    /// - Returns: Boolean indicating if the message likely includes a recipe format.
    func isLikelyRecipe(message: String) -> Bool {
        let requiredSections = ["**Title:**", "**Ingredients:**", "**Instructions:**"]
        return requiredSections.allSatisfy { message.contains($0) }
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

}
