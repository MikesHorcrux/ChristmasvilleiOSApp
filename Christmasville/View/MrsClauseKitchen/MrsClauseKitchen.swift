//
//  MrsClauseKitchen.swift
//  Christmasville
//
//  Created by Mike on 8/14/23.
//

import SwiftUI
import Observation
import SwiftData

struct MrsClauseKitchen: View {
    
    @Query(sort: \Recipe.title) var recipes: [Recipe]
    
    var body: some View {
        NavigationStack() {
            ZStack {
                VStack(alignment: .leading) {
                    
                    HStack(alignment: .top){
                        Text("Mrs Claus CookBook")
                            .font(.title)
                            .fontWeight(.bold)
                        .foregroundStyle(.santaRed)
                        .multilineTextAlignment(.leading)
                        Spacer()
                        Image("ginger bread man #2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 65)
                            .padding()
                            .neumorphicBackground(backgroundColor: .bellBrown)
                    }
                    ScrollView(.vertical){
                        VStack {
                            ForEach(recipes, id: \.self){ recipe in
                                NavigationLink {
                                    RecipeView(recipe: recipe)
                                } label: {
                                    FeaturedRecipeCard(recipe: recipe)
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .padding()
            .snowBackground()
        }
    }
}

#if DEBUG
struct MrsClauseKitchen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack() {
            MrsClauseKitchen()
        }
    }
}
#endif
