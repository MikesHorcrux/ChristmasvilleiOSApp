//
//  MrsClauseKitchen.swift
//  Christmasville
//
//  Created by Mike on 8/14/23.
//

import SwiftUI
import Observation

struct MrsClauseKitchen: View {
    @Environment(\.apiClient) var apiClient: APIClient
    @State var viewModel: MrsClauseKitchenViewModel
    @State var chatViewModel: MrsClauseKitchenChatViewModel
    @State var show = false
    init(apiClient: APIClient) {
        _viewModel = State(initialValue: MrsClauseKitchenViewModel())
        _chatViewModel = State(initialValue: MrsClauseKitchenChatViewModel())
    }
    
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
                            ForEach(viewModel.mrsClauseRecipe, id: \.self){ recipe in
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
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            show.toggle()
                        }, label: {
                            Image("christmas Mug - 1")
                        })
                        .buttonStyle(RoundGreenButtonStyle())
                    }
                }
            }
            .padding()
            .snowBackground()
            .onAppear(){
                Task{
                    await viewModel.getSavedMrsClauseRecipes()
                }
            }
            .task {
                if chatViewModel.messages.isEmpty {
                    await chatViewModel.startNewChat()
                }
            }
            .sheet(isPresented: $show, content: {
                MCKChatView(viewModel: chatViewModel)
        })
        }
    }
}

#if DEBUG
struct MrsClauseKitchen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack() {
            MrsClauseKitchen(apiClient: InMemoryAPIClient())
        }
    }
}
#endif
