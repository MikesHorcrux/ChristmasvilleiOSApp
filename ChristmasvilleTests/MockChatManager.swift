//
//  MockChatManager.swift
//  ChristmasvilleTests
//
//  Created by Mike  Van Amburg on 4/25/24.
//

import Foundation

class MockChatManager: ChatManager {
    var messagesToSend: [String] = []
    var simulateError: Error?

    override func sendMessage(_ text: String, streaming: Bool = true) {
        if let error = simulateError {
            onError?(error)
        } else {
            messagesToSend.append(text)
            let message = ChatMessage(message: text, participant: .system)
            onMessageUpdate?(message)
        }
    }

    func simulateIncomingMessage(_ message: String) {
        let chatMessage = ChatMessage(message: message, participant: .system)
        onMessageUpdate?(chatMessage)
    }
}

