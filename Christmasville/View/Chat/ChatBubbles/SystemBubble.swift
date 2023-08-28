//
//  SystemBubble.swift
//  Christmasville
//
//  Created by Mike on 8/14/23.
//

import SwiftUI

struct SystemBubble: View {
    var msg: String = ""
    var body: some View {
        Bubble(direction: .left) {
            Text(msg)
                .multilineTextAlignment(.leading)
                .padding(.all, 20)
                .foregroundColor(Color.white)
                .background(.coal)
                .textSelection(.enabled)
        }
        .padding(.trailing, 30)
        
    }
}

#Preview {
    ScrollView{
        SystemBubble(msg: "testing if this look good or not I have no clue")
    }
}
