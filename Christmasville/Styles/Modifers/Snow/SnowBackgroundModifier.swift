//
//  SnowBackgroundModifier.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 10/6/23.
//

import Foundation
import SwiftUI

struct SnowBackgroundModifier: ViewModifier {
    @AppStorage("showSnowFall") var showSnowFall: Bool = true
    
    func body(content: Content) -> some View {
        if showSnowFall {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(SnowBackground().ignoresSafeArea(edges: .all))
                .scrollContentBackground(.hidden)
        } else {
            content
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.snowBackground.ignoresSafeArea(edges: .all))
                        .scrollContentBackground(.hidden)
        }
        
    }
}

extension View {
    func snowBackground() -> some View {
        self.modifier(SnowBackgroundModifier())
    }
}
