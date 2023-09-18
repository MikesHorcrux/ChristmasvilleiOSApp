//
//  TextEntryView.swift
//  Christmasville
//
//  Created by Mike on 8/14/23.
//

import SwiftUI
import Observation

struct TextEntryView: View {
    @State var textentry: String
    var sendAction: () -> ()
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                TextField("", text: $textentry, prompt: Text(""), axis: .vertical)
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
                        sendAction()
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

#Preview {
    VStack {
        Spacer()
        TextEntryView(textentry: "Hey All"){}
    }
}
