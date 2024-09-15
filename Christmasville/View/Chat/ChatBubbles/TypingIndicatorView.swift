import SwiftUI

struct TypingIndicatorView: View {
    @State private var isAnimating = false

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .frame(width: 6, height: 6)
                .scaleEffect(isAnimating ? 0.5 : 1)
                .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(0), value: isAnimating)
            Circle()
                .frame(width: 6, height: 6)
                .scaleEffect(isAnimating ? 0.5 : 1)
                .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(0.2), value: isAnimating)
            Circle()
                .frame(width: 6, height: 6)
                .scaleEffect(isAnimating ? 0.5 : 1)
                .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(0.4), value: isAnimating)
        }
        .foregroundColor(Color("EverGreen"))
        .onAppear {
            isAnimating = true
        }
    }
}