//
//  ChatManager.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 4/24/24.
//

import Foundation
import GoogleGenerativeAI

/// Manages the interactions with a generative AI model for chat functionality.
class ChatManager {
    private var model: GenerativeModel
    private var chat: Chat

    /// A closure that is called when a new message is received from the system.
    var onMessageUpdate: ((ChatMessage) -> Void)?

    /// A closure that is called when an error occurs during message handling.
    var onError: ((Error) -> Void)?

    /// Initializes a new ChatManager with a specific system instruction.
    /// - Parameter systemInstruction: The instruction that defines the system's behavior in the chat.
    init(systemInstruction: String) {
        model = GenerativeModel(
            name: "gemini-1.5-pro-latest",
            apiKey: GoogleAIAPIKey.default,
            systemInstruction: .init(parts: [.text(systemInstruction)]),
            requestOptions: RequestOptions(apiVersion: "v1beta")
        )
        chat = model.startChat()
    }

    /// Sends a message to the chat service.
    /// - Parameters:
    ///   - text: The text message to send.
    ///   - streaming: Specifies whether to send the message as a streaming request.
    func sendMessage(_ text: String, streaming: Bool = true) {
        if streaming {
            sendMessageStreaming(text)
        } else {
            sendMessageNonStreaming(text)
        }
    }

    /// Handles the sending of a message in streaming mode.
    /// - Parameter text: The text message to send.
    private func sendMessageStreaming(_ text: String) {
        let responseStream = chat.sendMessageStream(text)
        Task {
            do {
                for try await chunk in responseStream {
                    if let text = chunk.text {
                        let message = ChatMessage(message: text, participant: .system, pending: false)
                        onMessageUpdate?(message)
                    }
                }
            } catch {
                onError?(error)
            }
        }
    }

    /// Sends a message to the chat service in non-streaming mode.
    /// - Parameter text: The text message to send.
    private func sendMessageNonStreaming(_ text: String) {
        Task {
            do {
                let response = try await chat.sendMessage(text)
                if let responseText = response.text {
                    let message = ChatMessage(message: responseText, participant: .system, pending: false)
                    onMessageUpdate?(message)
                }
            } catch {
                onError?(error)
            }
        }
    }

    /// Resets the chat session to start a new conversation.
    func startNewChat() {
        chat = model.startChat()
    }
}
