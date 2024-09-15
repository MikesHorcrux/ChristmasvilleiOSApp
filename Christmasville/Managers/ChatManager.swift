import Foundation
import Observation
import FirebaseVertexAI

@Observable
class ChatManager {

    var messages = [CVChatMessage]()
    var busy = false
    var error: Error?

    func sendMessage(_ text: String, streaming: Bool = false, systemInstructions: String) {
        if !messages.isEmpty {
            let userMessage = CVChatMessage(message: text, participant: .user)
            messages.append(userMessage)
        }
        sendMessageNonStreaming(text, systemInstructions: systemInstructions)
    }

    private func sendMessageNonStreaming(_ text: String, systemInstructions: String) {
        let vertex = VertexAI.vertexAI()
        let model = vertex.generativeModel(modelName: "gemini-1.5-pro", systemInstruction: .init(parts: [.text(systemInstructions)]))
        Task {
            do {
                // Ensure UI updates are on the main thread
                await MainActor.run {
                    busy = true
                    // Add a placeholder system message with pending = true
                    let placeholderMessage = CVChatMessage(message: "", participant: .system, pending: true)
                    messages.append(placeholderMessage)
                }
                let messageIndex = messages.count - 1

                // Generate the content (this can be on a background thread)
                let response = try await model.generateContent(text)
                if let responseText = response.text {
                    // Update the placeholder message on the main thread
                    await MainActor.run {
                        messages[messageIndex].message = responseText
                        messages[messageIndex].pending = false
                        busy = false
                    }
                }
            } catch {
                print(error)
                // Handle error on the main thread
                await MainActor.run {
                    if messages.indices.contains(messages.count - 1) {
                        messages[messages.count - 1].message = "Error: Unable to get response."
                        messages[messages.count - 1].pending = false
                    }
                    busy = false
                }
            }
        }
    }
}
