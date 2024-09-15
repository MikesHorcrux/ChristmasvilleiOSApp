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
    @Environment(\.dismiss) var dismiss
    @Query(sort: \Recipe.title) var recipes: [Recipe]
    @State var showMrsClausChat = false
    var body: some View {
        NavigationStack() {
            VStack(alignment: .leading) {
                if recipes.isEmpty {
                    CookBookEmptyView()
                } else {
                    ScrollView(.vertical, showsIndicators: true){
                        VStack {
                            ForEach(recipes, id: \.self){ recipe in
                                NavigationLink {
                                    RecipeView(recipe: recipe)
                                } label: {
                                    FeaturedRecipeCard(recipe: recipe)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
            //.padding()
            .snowBackground()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button() {
                        showMrsClausChat.toggle()
                    } label: {
                        HStack {
                            Image("christmas Mug - 1")
                            Text("Mrs. Claus")
                        }
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink() {
                        AddRecipie()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Image("Candy Christmas - 4")
                            
                        }
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                }
            }
            //MARK: Sheets
#if os(visionOS)
            .sheet(isPresented: $showMrsClausChat) {
                ZStack(alignment: .topTrailing) {
                    ChatView(bot: .mrsClaus, showCapsule: false)
                        .frame(minWidth: 250, maxWidth: 450, minHeight: 400, maxHeight: .infinity)
                    Button("close"){
                        showMrsClausChat.toggle()
                    }
                    .padding()
                }
            }
#else
            .sheet(isPresented: $showMrsClausChat) {
                    ChatView(bot: .mrsClaus, showCapsule: true)
            }
            #endif
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
