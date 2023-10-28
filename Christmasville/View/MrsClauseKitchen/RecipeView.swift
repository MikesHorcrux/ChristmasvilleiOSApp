//
//  RecipeView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 10/2/23.
//

import SwiftUI
import Observation

struct RecipeView: View {
    var recipe: Recipe
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Instructions: ")
                        .font(.title3)
                    Spacer()
                }
                Divider()
                    .frame(width: 100)
                Text(recipe.ingredients)
                    .multilineTextAlignment(.leading)
                    
            }
            .padding()
            .neumorphicBackground()
            .padding()
            
            VStack(alignment: .leading) {
                Text("Instructions: ")
                    .font(.title3)
                Divider()
                    .frame(width: 100)
                Text(recipe.instructions)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .neumorphicBackground()
            .padding()
        }
        .toolbarBackground(Color.snowBackground, for: .navigationBar)
        .background(SnowBackground().ignoresSafeArea(edges: .all))
        .navigationTitle(recipe.title)
    }
}

#Preview {
    NavigationStack {
        RecipeView(recipe: Recipe(id: "", title: "", ingredients: "", instructions: ""))
    }
}
