//
//  NeumorphicBackground.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 9/24/23.
//

import Foundation
import SwiftUI

/// A `ViewModifier` that applies a neumorphic design background to the content.
///
/// This modifier provides a standard neumorphic design by applying a specific fill color along with
/// light and dark shadow to give the view a raised appearance.
struct NeumorphicBackground: ViewModifier {
    /// The corner radius of the background.
    let cornerRadius: CGFloat
    
    /// The background color.
    let backgroundColor: Color

    /// Creates a neumorphic background modifier.
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius of the background. Default is `15`.
    ///   - backgroundColor: The background color. Default is `Color("SnowBackground")`.
    init(cornerRadius: CGFloat = 15, backgroundColor: Color = Color("SnowBackground")) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
    }

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.backgroundCV)
                    .shadow(color: Color.white.opacity(0.02), radius: 5, x: -5, y: -5) // Light shadow
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)  // Dark shadow
            )
    }
}

extension View {
    /// Adds a neumorphic design background to the view.
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius for the background. Default is `15`.
    ///   - backgroundColor: The color to use for the background. Default is `Color("SnowBackground")`.
    ///
    /// - Returns: A view that has a neumorphic design background.
    func neumorphicBackground(cornerRadius: CGFloat = 15, backgroundColor: Color = Color("SnowBackground")) -> some View {
        self.modifier(NeumorphicBackground(cornerRadius: cornerRadius, backgroundColor: backgroundColor))
    }
}

//// Usage:
//struct ContentView: View {
//    var body: some View {
//        Text("Hello, Neumorphism!")
//            .padding()
//            .neumorphicBackground()
//    }
//}
