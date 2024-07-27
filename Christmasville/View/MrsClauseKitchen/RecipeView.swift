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
                    Text("Ingredents: ")
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
                HStack {
                    Text("Instructions: ")
                        .font(.title3)
                    Spacer()
                }
                Divider()
                    .frame(width: 100)
                Text(recipe.instructions)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .neumorphicBackground()
            .padding()
            
            if let tip = recipe.tip {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Tips: ")
                            .font(.title3)
                        Spacer()
                    }
                    Divider()
                        .frame(width: 100)
                    Text(tip)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .neumorphicBackground()
                .padding()
            }
            
        }
#if !os(macOS)
        .toolbarBackground(Color.snowBackground, for: .navigationBar)
            #endif
        
        .background(SnowBackground().ignoresSafeArea(edges: .all))
        .navigationTitle(recipe.title)
    }
}

#Preview {
    NavigationStack {
        RecipeView(recipe: Recipe(title: "", ingredients: "", instructions: ""))
    }
}
