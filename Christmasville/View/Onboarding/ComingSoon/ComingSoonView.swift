//
//  ComingSoonView.swift
//  Christmasville
//
//  Created by Mike on 9/4/23.
//

import SwiftUI

struct ComingSoonView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Coming Soon")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.everGreen)
            Text("Ho Ho Ho! Santa is preparing surprises!")
                .font(.title3)
                .foregroundStyle(.santaRed)
            Spacer()
            Image("santa with snowball")
                .resizable()
                .scaledToFit()
        }
        .background(SnowBackground().ignoresSafeArea(edges: .all))
    }
}

#Preview {
    ComingSoonView()
}
