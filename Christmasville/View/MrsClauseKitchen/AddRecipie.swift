//
//  AddRecipie.swift
//  Christmasville
//
//  Created by Mike on 9/17/23.
//

import SwiftUI
import SwiftData

struct AddRecipie: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State var title: String = ""
    @State var ingredients: String = ""
    @State var instructions: String = ""
    @State var tips: String = ""
    

    var body: some View {
        Form {
            Section(header: Text("Recipe Name")) {
                TextField("Egg nog latte", text: $title)
            }
            
            Section(header: Text("Ingredients")) {
                TextField("Lets add all the ingredients...", text: $ingredients, axis: .vertical)
            }
            
            Section(header: Text("instructions")) {
                TextField("Make sure to add all the instructions...", text: $instructions, axis: .vertical)
            }
            
            Section(header: Text("Tips")) {
                TextField("Any additional tips...", text: $tips, axis: .vertical)
            }
            
            HStack {
                Spacer()
                Image("leaf")
                    .resizable()
                    .scaledToFit()
                .frame(height: 110)
                Spacer()
            }
            .listRowBackground(Color.clear)
        }
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Button("Save") {
                    saveRecipe()
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
        })
        #if os(iOS)
        .toolbar(.hidden, for: .tabBar)
        #endif
        .scrollContentBackground(.hidden)
        .snowBackground()
    }
    
    func saveRecipe() {
        let recipe = Recipe(title: title, ingredients: ingredients, instructions: instructions, tip: tips)
        
        modelContext.insert(recipe)
        dismiss()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Recipe.self, configurations: config)
    
    NavigationStack() {
        AddRecipie()
            .modelContainer(container)
    }
}
