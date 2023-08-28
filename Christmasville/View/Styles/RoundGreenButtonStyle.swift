//
//  RoundGreenButtonStyle.swift
//  Christmasville
//
//  Created by Mike on 7/8/23.
//

import SwiftUI

struct RoundGreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(.white)
            .background(Color.everGreen)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    Button(action: {}, label: {
        HStack {
            Image("Bulbs")
        }
    })
        .buttonStyle(RoundGreenButtonStyle())
}
