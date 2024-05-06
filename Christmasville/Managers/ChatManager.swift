//
//  ChatManager.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 4/24/24.
//

import Foundation
import GoogleGenerativeAI
import Observation

/// Manages the interactions with a generative AI model for chat functionality.
@Observable
class ChatManager {
    var chat: Chat
    
    var messages = [ChatMessage]()
    var busy = false
    var error: Error?

    /// Initializes a new ChatManager with a specific system instruction.
    /// - Parameter systemInstruction: The instruction that defines the system's behavior in the chat.
    init(systemInstruction: String) {
       let model = GenerativeModel(
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
    func sendMessage(_ text: String, streaming: Bool = false) {
        if !messages.isEmpty{
            let userMessage = ChatMessage(message: text, participant: .user)
            messages.append(userMessage)
        }
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
                        messages.append(message)
                    }
                }
            } catch {
               print(error)
                busy = false
            }
        }
    }

    /// Sends a message to the chat service in non-streaming mode.
    /// - Parameter text: The text message to send.
    private func sendMessageNonStreaming(_ text: String) {
        Task {
            do {
                busy.toggle()
                let response = try await chat.sendMessage(text)
                if let responseText = response.text {
                    let message = ChatMessage(message: responseText, participant: .system, pending: false)
                    messages.append(message)
                    busy.toggle()
                }
            } catch {
                print(error)
                busy.toggle()
            }
        }
    }
}
