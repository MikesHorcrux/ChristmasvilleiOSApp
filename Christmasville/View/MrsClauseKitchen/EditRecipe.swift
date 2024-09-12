//
//  EditRecipe.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 9/11/24.
//

import SwiftUI
import SwiftData

struct EditRecipie: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State var recipe: Recipe
    

    var body: some View {
        Form {
            Section(header: Text("Recipe Name")) {
                TextField("Egg nog latte", text: $recipe.title)
            }
            
            Section(header: Text("Ingredients")) {
                TextField("Lets add all the ingredients...", text: $recipe.ingredients, axis: .vertical)
            }
            
            Section(header: Text("instructions")) {
                TextField("Make sure to add all the instructions...", text: $recipe.instructions, axis: .vertical)
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
                    dismiss()
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
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Recipe.self, configurations: config)
    
    NavigationStack() {
        EditRecipie()
            .modelContainer(container)
    }
}
