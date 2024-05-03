//
//  FeaturedRecipeCard.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 9/26/23.
//

import SwiftUI

struct FeaturedRecipeCard: View {
    var recipe: Recipe
    var body: some View {
        VStack{
            HStack(alignment: .center) {
                Text(recipe.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.everGreen)
                Spacer()
                ZStack {
                    WavySquareShape(waveCount: 15, amplitude: 3)
                        .foregroundColor(.bellBrown)
                    Image("tartlet")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                
                .frame(width: 60, height: 60)
                .padding()
            }
            HStack(alignment: .top){
                Text(recipe.instructions)
                    .font(.subheadline)
                    .fontWeight(.light)
                Divider()
                Text(recipe.ingredients)
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            .multilineTextAlignment(.leading)
            .tint(.primary)
            .frame(maxHeight: 250)
        }
        .padding()
        .frame(maxWidth: 3304)
        .neumorphicBackground()
        .padding()
    }
}

#Preview {
    FeaturedRecipeCard(recipe: Recipe(title: "testing", ingredients: "ingrediants", instructions: ""))
}
