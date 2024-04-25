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
    @FocusState private var chatFeildIsFocused: Bool
    var body: some View {
        ScrollViewReader { scrollView in
            ZStack{
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(Array(viewModel.messages.enumerated()), id: \.offset) { index, message in
                            HStack {
                                if message.participant == .user{
                                    Spacer()
                                    UserChatBubble(msg: message.message)
                                } else {
                                    SystemBubble(msg: message.message)
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                }
                .gesture(
                    DragGesture(minimumDistance: 17, coordinateSpace: .local)  // Use a small minimum distance to ensure that the drag is deliberate
                        .onChanged { value in
                            if value.startLocation.y < value.location.y {  // Dragging downwards
                                chatFeildIsFocused = false
                            }
                        }
                )
                .padding(.top, 25)
                .padding(.bottom, 100)
                .keyboardAvoiding()
                VStack {
                    Spacer()
                    textEntyView
                        .focused($chatFeildIsFocused)
                }
                .keyboardAvoiding()
                VStack {
                    Capsule()
                        .frame(width: 40, height: 6)
                        .opacity(0.2)
                    Spacer()
                }
                .padding()
            }
            
            .padding(.bottom, -39)
            .background(SnowBackground().ignoresSafeArea(edges: .all))
            .onChange(of: viewModel.messages) { measages in
                let lastIndex = viewModel.messages.count - 1
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
                    if chatFeildIsFocused {
                        Button {
                            chatFeildIsFocused = false
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                                .fontWeight(.semibold)
                                .font(.body)
                                .foregroundColor(Color.everGreen)
                                .padding(5)
                                .background(.lightgreen)
                                .clipShape(Circle())
                        }
                    }
                    Button {
                        viewModel.sendMessage(viewModel.textEntry)
                    } label: {
                        Image(systemName: "arrow.up")
                            .fontWeight(.semibold)
                            .font(.body)
                            .foregroundColor(Color.everGreen)
                            .padding(5)
                            .background(.lightgreen)
                            .clipShape(Circle())
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
    MCKChatView(viewModel: MrsClauseKitchenChatViewModel())
}
#endif
