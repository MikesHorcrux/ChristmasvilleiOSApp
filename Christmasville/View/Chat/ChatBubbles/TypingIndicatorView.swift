//
//  TypingIndicatorView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 9/14/24.
//


import SwiftUI

struct TypingIndicatorView: View {
    @State private var isAnimating = false

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .frame(width: 16, height: 16)
                .scaleEffect(isAnimating ? 0.5 : 1)
                .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(0), value: isAnimating)
            Circle()
                .frame(width: 16, height: 16)
                .scaleEffect(isAnimating ? 0.5 : 1)
                .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(0.2), value: isAnimating)
            Circle()
                .frame(width: 16, height: 16)
                .scaleEffect(isAnimating ? 0.5 : 1)
                .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(0.4), value: isAnimating)
        }
        .foregroundColor(Color("lightgreen"))
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    TypingIndicatorView()
}
