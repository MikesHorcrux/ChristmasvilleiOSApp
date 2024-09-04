//
//  ChatManager.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 4/24/24.
//

import Foundation
import Observation
import FirebaseVertexAI

/// Manages the interactions with a generative AI model for chat functionality.
@Observable
class ChatManager {
  
    var messages = [CVChatMessage]()
    var busy = false
    var error: Error?

    /// Sends a message to the chat service.
    /// - Parameters:
    ///   - text: The text message to send.
    ///   - streaming: Specifies whether to send the message as a streaming request.
    func sendMessage(_ text: String, streaming: Bool = false, systemInstructions: String) {
        if !messages.isEmpty{
            let userMessage = CVChatMessage(message: text, participant: .user)
            messages.append(userMessage)
        }
        sendMessageNonStreaming(text, systemInstructions: systemInstructions)
    }

    /// Sends a message to the chat service in non-streaming mode.
    /// - Parameter text: The text message to send.
    private func sendMessageNonStreaming(_ text: String, systemInstructions: String) {
        // Initialize the Vertex AI service
        let vertex = VertexAI.vertexAI()

        // Initialize the generative model with a model that supports your use case
        // Gemini 1.5 models are versatile and can be used with all API capabilities
        let model = vertex.generativeModel(modelName: "gemini-1.5-pro", systemInstruction: .init(parts: [.text(systemInstructions)]))
        Task {
            do {
                busy.toggle()
                // To generate text output, call generateContent with the text input
                let response = try await model.generateContent(text)
                if let responseText = response.text {
                    let message = CVChatMessage(message: responseText, participant: .system, pending: false)
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
