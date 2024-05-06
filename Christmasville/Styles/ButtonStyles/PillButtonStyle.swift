//
//  PillButtonStyle.swift
//  Christmasville
//
//  Created by Mike on 6/14/23.
//

import SwiftUI

struct SantaRedPillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .frame(width: 200, height: 50)
            .background(Color.santaRed)
            .clipShape(Capsule())
    }
}

#Preview {
    Button("Im a button"){}
        .buttonStyle(SantaRedPillButtonStyle())
}
