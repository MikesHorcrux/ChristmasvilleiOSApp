//
//  SystemBubble.swift
//  Christmasville
//
//  Created by Mike on 8/14/23.
//

import SwiftUI
import MarkdownUI

struct SystemBubble: View {
    var msg: String = ""
    var body: some View {
        Bubble(direction: .left) {
            Markdown(msg)
                .multilineTextAlignment(.leading)
                .padding(.all, 20)
                .background(.coal)
                .textSelection(.enabled)
                .markdownTextStyle(\.text) {
                    ForegroundColor(.white)
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
