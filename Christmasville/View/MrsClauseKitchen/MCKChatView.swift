//
//  MCKChatView.swift
//  Christmasville
//
//  Created by Mike on 9/13/23.
//

import SwiftUI
import Observation

struct MCKChatView: View {
    
    @Environment(\.modelContext) var modelContext

    @State var textEntry: String = ""
    @FocusState private var chatFeildIsFocused: Bool
    
    @State var chat: ChatManager = ChatManager(systemInstruction: """
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
    """)
    
    var body: some View {
        ScrollViewReader { scrollView in
            ZStack{
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(Array(chat.messages.enumerated()), id: \.offset) { index, message in
                            HStack {
                                if message.participant == .user{
                                    Spacer()
                                    UserChatBubble(msg: message.message)
                                } else {
                                    
                                    SystemBubble(msg: message.message)
                                        .onAppear {parseAndHandleMessage(message)}
                                }
                            }
                        }
                    }
                    
                }
                .gesture(
                    DragGesture(minimumDistance: 17, coordinateSpace: .local)  // Use a small minimum distance to ensure that the drag is deliberate
                        .onChanged { value in
                            if value.startLocation.y < value.location.y {  // Dragging downwards
                                chatFeildIsFocused = false
                            }
                        }
                )
                .padding(.top, 25)
                .padding(.bottom, 100)
                
                VStack {
                    Spacer()
                    textEntyView
                        .focused($chatFeildIsFocused)
                }
                VStack {
                    Capsule()
                        .frame(width: 40, height: 6)
                        .opacity(0.2)
                    Spacer()
                }
                .padding()
            }
            
            .padding(.bottom, -39)
            .background(SnowBackground().ignoresSafeArea(edges: .all))
            .onChange(of: chat.messages) { measages in
                let lastIndex = chat.messages.count - 1
                if lastIndex >= 0 {
                    scrollView.scrollTo(lastIndex, anchor: .bottom)
                }
            }
            .onAppear(){
                if chat.messages.isEmpty {
                    chat.sendMessage("Hey", streaming: false)
                }
            }
        }
        
    }
    
    private var textEntyView: some View {
        ZStack(alignment: .bottom) {
            VStack {
                TextField("", text: $textEntry, prompt: Text(""), axis: .vertical)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.white.opacity(0.06))
                    .cornerRadius(20)
                    .padding(.trailing, 80)
                    .padding(10)
            }
            HStack {
                Spacer()
                HStack {
                    if chatFeildIsFocused {
                        Button {
                            chatFeildIsFocused = false
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                                .fontWeight(.semibold)
                                .font(.body)
                                .foregroundColor(Color.everGreen)
                                .padding(5)
                                .background(.lightgreen)
                                .clipShape(Circle())
                        }
                    }
                    Button {
                        chat.sendMessage(textEntry)
                        textEntry = ""
                    } label: {
                        Image(systemName: "arrow.up")
                            .fontWeight(.semibold)
                            .font(.body)
                            .foregroundColor(Color.everGreen)
                            .padding(5)
                            .background(.lightgreen)
                            .clipShape(Circle())
                    }
                }
                .padding([.trailing, .bottom],14)
            }
        }
        .padding(.bottom, 50)
        .background(.coal)
        .cornerRadius(25)
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
                print(recipe.title)
                modelContext.insert(recipe)
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
}

#if DEBUG
#Preview {
    MCKChatView()
}
#endif
