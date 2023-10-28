//
//  KeyboardAvoidence.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 9/23/23.
//

import Foundation
import SwiftUI
import Combine

public extension View {
    func keyboardAvoiding() -> some View {
        #if os(iOS)
        return AnyView(modifier(KeyboardAvoiding()))
        #else
        return AnyView(self)
        #endif
    }
}

public extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        #if os(iOS)
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
        #else
        return Just(0).eraseToAnyPublisher()  // Return a publisher that emits 0 for macOS
        #endif
    }
}

public extension Notification {
    var keyboardHeight: CGFloat {
        #if os(iOS)
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
        #else
        return 0  // Return 0 for macOS
        #endif
    }
}

public struct KeyboardAvoiding: ViewModifier {
    @State private var keyboardActiveAdjustment: CGFloat = 0

    public func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom, spacing: keyboardActiveAdjustment) {
                EmptyView().frame(height: 0)
            }
            .onReceive(Publishers.keyboardHeight) {
                self.keyboardActiveAdjustment = min($0, 10)
            }
    }
}

