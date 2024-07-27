//
//  SnowBackgroundModifier.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 10/6/23.
//

import Foundation
import SwiftUI

struct SnowBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(SnowBackground().ignoresSafeArea(edges: .all))
            .scrollContentBackground(.hidden)
    }
}

extension View {
    func snowBackground() -> some View {
        self.modifier(SnowBackgroundModifier())
    }
}
