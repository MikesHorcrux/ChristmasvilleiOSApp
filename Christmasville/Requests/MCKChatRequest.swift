//
//  MCKChatRequest.swift
//  Christmasville
//
//  Created by Mike on 9/13/23.
//

import Foundation

struct MCKChatRequest: Request {
    typealias ReturnType = Conversation
    
    let method: HTTPMethod = .post
    let conversation: Conversation
    
    var path: String {
        "MCK"
    }
    
    var bodyData: Data? {
        try? JSON.encoder.encode(conversation)
    }
}
