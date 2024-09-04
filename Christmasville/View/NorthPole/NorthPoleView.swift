//
//  NorthPoleView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 9/2/24.
//

import SwiftUI

struct NorthPoleView: View {
    var bots: [Bots] = Bots.allCases
    var body: some View {
        NavigationStack {
            List(bots, id: \.self) { bot in
                NavigationLink(destination: ChatView(bot: bot)) {
                    NorthPoleContactView(image: bot.image, name: bot.name)
                }
            }
            .snowBackground()
        }
    }
}

#Preview {
    NorthPoleView()
}
