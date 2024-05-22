//
//  MiniRecipeCard.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 9/24/23.
//

import SwiftUI
import Observation

struct MiniRecipeCard: View {
    var recipe: Recipe
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(recipe.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.everGreen)
                Divider()
                    .frame(width: 20)
                Text(recipe.ingredients)
                    .tint(.primary)
                    .font(.footnote)
                    .fontWeight(.light)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            Spacer()
            ZStack {
                WavySquareShape(waveCount: 15, amplitude: 3)
                    .foregroundColor(.bellBrown)
                Image("tartlet")
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            .frame(width: 70, height: 70)
            .padding()
        }
        .padding()
        .frame(maxWidth: 300, maxHeight: 130)
        .neumorphicBackground()
        .padding()
    }
}

#Preview {
    MiniRecipeCard(recipe: Recipe(title: "testing", ingredients: "ingrediants", instructions: ""))
        .padding()
        .background(SnowBackground().edgesIgnoringSafeArea(.all))
}
