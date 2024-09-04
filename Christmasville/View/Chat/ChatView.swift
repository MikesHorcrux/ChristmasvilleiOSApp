//
//  ChatView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 6/14/24.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    @Environment(\.modelContext) var modelContext
    
    var bot: Bots
    @State var textEntry: String = ""
    @FocusState private var chatFeildIsFocused: Bool
    
    @State var chat: ChatManager = ChatManager()
    
    @State var showSheet: Bool = false
    var showCapsule: Bool = false
    
    var body: some View {
        ScrollViewReader { scrollView in
            ZStack{
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(Array(chat.messages.enumerated()), id: \.offset) { index, message in
                            HStack {
                                if message.participant == .user{
                                    if containsGiftMessage(in: message.message) {
                                        HStack {
                                            Image("sock")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                            Text("Checking Santa's List...")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color("EverGreen"))
                                        }
                                        .padding()
                                        .background(Color("SnowBackground"))
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        Spacer()
                                    } else {
                                        Spacer()
                                        UserChatBubble(msg: message.message)
                                    }
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
                //.padding(.top, 25)
                .padding(.bottom, bot == .santasWorkshop ? 150 : 100)
                
                VStack {
                    Spacer()
                    textEntyView
                        .focused($chatFeildIsFocused)
                }
                if showCapsule {
                    VStack {
                        Capsule()
                            .frame(width: 100, height: 10)
                            .foregroundStyle(Color("EverGreen"))
                        Spacer()
                    }
                    .padding(.top)
                }
            }
            
            .padding(.bottom, -35)
            .background(SnowBackground().ignoresSafeArea(edges: .all))
            .onChange(of: chat.messages) { measages in
                let lastIndex = chat.messages.count - 1
                if lastIndex >= 0 {
                    scrollView.scrollTo(lastIndex, anchor: .bottom)
                }
            }
            .onAppear(){
                if chat.messages.isEmpty {
                    chat.sendMessage("Hey", streaming: false, systemInstructions: bot.prompt)
                }
            }
            //MARK: Sheets
            .sheet(isPresented: $showSheet) {
                GifteeChatSelection() { giftee in
                    addGifteetoChat(giftee)
                    showSheet.toggle()
                }
            }
        }
        #if os(iOS)
        .toolbar(.hidden, for: .tabBar)
        #endif
    }
    
    private var textEntyView: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                if bot == .santasWorkshop {
                    Button("Add Giftee") {
                        showSheet = true
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .padding()
                }
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
                        chat.sendMessage(textEntry, systemInstructions: bot.prompt)
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
        .padding(.bottom, 30)
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
    func parseAndHandleMessage(_ message: CVChatMessage) {
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

    func addGifteetoChat(_ giftee: Giftee) {
        let messages = """
        Can you help me find gift ideas for \(giftee.name), who is \(giftee.age). here is what I know
        activities: \(giftee.activities)
        interests: \(giftee.interests)
        hobbies: \(giftee.hobbies)
        relation: \(giftee.relation)
        """
        chat.sendMessage(messages, systemInstructions: bot.prompt)
    }
    
    func containsGiftMessage(in text: String) -> Bool {
        let pattern = #"Can you help me find gift ideas for"#

        return text.range(of: pattern, options: .regularExpression) != nil
    }
    
}

#Preview {
    var previewData: [Giftee] = [
        Giftee(name: "Mike", sex: "Male", age: "25", activities: "Swimming, Basketball", interests: "Cooking, Video Games", hobbies: "Hiking, Camping", relation: .family, giftStatus: .purchased, trackingNumber: "123456789"),
        Giftee(name: "Sarah", sex: "Female", age: "23", activities: "Swimming, Basketball", interests: "Cooking, Video Games", hobbies: "Hiking, Camping", relation: .family, giftStatus: .purchased, trackingNumber: "123456789"),
        Giftee(name: "John", sex: "Male", age: "27", activities: "Swimming, Basketball", interests: "Cooking, Video Games", hobbies: "Hiking, Camping", relation: .family, giftStatus: .purchased, trackingNumber: "123456789"),
        ]
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Giftee.self, configurations: config)

        for giftee in previewData{
            container.mainContext.insert(giftee)
        }

    return ChatView(bot: .santasWorkshop)
        .modelContainer(container)
   
}
