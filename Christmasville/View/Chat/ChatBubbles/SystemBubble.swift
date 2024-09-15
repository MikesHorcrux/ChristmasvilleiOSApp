//
//  SystemBubble.swift
//  Christmasville
//
//  Created by Mike on 8/14/23.
//

import SwiftUI

struct SystemBubble: View {
    var msg: String? = nil
    var isPending: Bool = false

    var body: some View {
        HStack {
            if isPending {
                Bubble(direction: .left) {
                    TypingIndicatorView()
                        .padding(.all, 20)
                        .background(.coal)
                        .textSelection(.enabled)
                        .foregroundColor(.white)
                }
                Spacer()
            } else if let msg = msg {
                Bubble(direction: .left) {
                    Text(msg)
                        .multilineTextAlignment(.leading)
                        .padding(.all, 20)
                        .background(.coal)
                        .textSelection(.enabled)
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .padding(.trailing, 30)
    }
}

#Preview {
    ScrollView{
        SystemBubble(msg: "testing if this look good or not I have no clue")
    }
}
