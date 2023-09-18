//
//  MCKChatView.swift
//  Christmasville
//
//  Created by Mike on 9/13/23.
//

import SwiftUI
import Observation

struct MCKChatView: View {
    @State var viewModel: MrsClauseKitchenChatViewModel
    @State var textEntry: String = ""
    var body: some View {
        ScrollViewReader { scrollView in
            ZStack{
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(Array(viewModel.chat.enumerated()), id: \.offset) { index, message in
                            HStack {
                                if message.role == "user"{
                                    Spacer()
                                    UserChatBubble(msg: message.content)
                                } else {
                                    SystemBubble(msg: message.content)
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                }
                .padding(.bottom, 100)
                VStack {
                    Spacer()
                    textEntyView
                }
            }
            .ignoresSafeArea(.all)
            .onChange(of: viewModel.chat) { _ in
                let lastIndex = viewModel.chat.count - 1
                if lastIndex >= 0 {
                    scrollView.scrollTo(lastIndex, anchor: .bottom)
                }
            }
        }
        
    }
    
    private var textEntyView: some View {
        ZStack(alignment: .bottom) {
            VStack {
                TextField("", text: $viewModel.textEntry, prompt: Text(""), axis: .vertical)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.white.opacity(0.06))
                    .cornerRadius(20)
                    .padding(.trailing, 80)
                    .padding(10)
            }
            HStack {
                Spacer()
                HStack {
                    Button {
                        viewModel.sendMsg()
                    } label: {
                        Image(systemName: "arrow.up")
                            .fontWeight(.semibold)
                            .font(.body)
                            .foregroundColor(Color.everGreen)
                            .padding(5)
                            .background(.lightgreen)
                            .clipShape(Circle())
                            //.padding()
                    }
                }
                .padding([.trailing, .bottom],14)
            }
        }
        .padding(.bottom, 50)
        .background(.coal)
        .cornerRadius(25)
    }
}

#if DEBUG
#Preview {
    MCKChatView(viewModel: MrsClauseKitchenChatViewModel(client: InMemoryAPIClient()))
}
#endif
