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
    @State var viewModel: MrsClauseKitchenChatViewModel
    @State var show = true
    init(apiClient: APIClient) {
        _viewModel = State(initialValue: MrsClauseKitchenChatViewModel(client: apiClient))
    }
    
    var body: some View {
        Text("Hey Bitch ")
            .task {
                await viewModel.testing()
                
                if viewModel.chat.isEmpty {
                    await viewModel.sendConversation()
                }
                
            }
            .sheet(isPresented: $show, content: {
                MCKChatView(viewModel: viewModel)
            })
    }
}

#if DEBUG
struct MrsClauseKitchen_Previews: PreviewProvider {
    static var previews: some View {
        MrsClauseKitchen(apiClient: InMemoryAPIClient())
    }
}
#endif
