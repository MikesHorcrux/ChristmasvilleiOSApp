//
//  UserBubble.swift
//  Christmasville
//
//  Created by Mike on 8/14/23.
//

import SwiftUI

import SwiftUI

struct UserChatBubble: View {
    var msg: String = ""
    var body: some View {
        Bubble(direction: .right) {
            Text(msg)
                .multilineTextAlignment(.leading)
                .padding(.all, 20)
                .foregroundColor(Color.white)
                .background(.everGreen)
                .textSelection(.enabled)
        }
        .padding(.leading, 30)
        
    }
}
#Preview {
    ScrollView {
        UserChatBubble()
        UserChatBubble(msg: "Hey...")
        UserChatBubble(msg: "Harry, Ron, and Hermione were all sitting in the Gryffindor common room one day when they started talking about their favorite types of magic.")
    }
}
