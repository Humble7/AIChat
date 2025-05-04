//
//  MockAIService.swift
//  AIChat
//
//  Created by ChenZhen on 30/4/25.
//

import SwiftUI

struct MockAIService: AIService {
    func generateImage(input: String) async throws -> UIImage {
        try await Task.sleep(for: .seconds(3))
        return UIImage(systemName: "star.fill")!
    }
    
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel {
        try await Task.sleep(for: .seconds(2))

        return AIChatModel(role: .assistant, message: "This is returned text from the AI.")
    }
}
