//
//  Bubble.swift
//  Christmasville
//
//  Created by Mike on 8/14/23.
//

import SwiftUI

struct Bubble<Content>: View where Content: View {
    let direction: BubbleShape.Direction
    let content: () -> Content
    init(direction: BubbleShape.Direction, @ViewBuilder content: @escaping () -> Content) {
            self.content = content
            self.direction = direction
    }
    
    var body: some View {
        HStack {
            if direction == .right {
                Spacer()
            }
            content().clipShape(BubbleShape(direction: direction))
            if direction == .left {
                Spacer()
            }
        }.padding([(direction == .left) ? .leading : .trailing, .top, .bottom], 20)
        .padding((direction == .right) ? .leading : .trailing, 50)
    }
}

#Preview {
    Bubble(direction: .left) {
                        Text("Hello!")
                            .padding(.all, 20)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                    }
}
