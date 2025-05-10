//
//  MockChatService.swift
//  AIChat
//
//  Created by ChenZhen on 7/5/25.
//

import Foundation

@MainActor
class MockChatService: ChatService {

    let delay: Double
    let showError: Bool

    let chats: [ChatModel]

    @Published var messages: [ChatMessageModel]

    init(
        chats: [ChatModel] = ChatModel.mocks,
        messages: [ChatMessageModel] = ChatMessageModel.mocks,
        delay: Double = 0.0,
        showError: Bool = false
    ) {
        self.chats = chats
        self.messages = messages
        self.delay = delay
        self.showError = showError
    }

    func createNewChat(chat: ChatModel) async throws {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
    }

    func getChat(userId: String, avatarId: String) async throws -> ChatModel? {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return chats.first {
            $0.userId == userId && $0.avatarId == avatarId
        }
    }

    func getAllChats(userId: String) async throws -> [ChatModel] {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()

        return chats
    }

    func addChatMessage(chatId: String, message: ChatMessageModel) async throws {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        messages.append(message)
    }

    func getLastChatMessage(chatId: String) async throws -> ChatMessageModel? {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return ChatMessageModel.mock
    }

    func streamChatMessages(chatId: String, onListenerConfigured: @escaping (AnyListener) -> Void) -> AsyncThrowingStream<[ChatMessageModel], Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(messages)

            Task {
                for await value in $messages.values {
                    continuation.yield(value)
                }
            }
        }
    }

    func deleteChat(chatId: String) async throws {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
    }

    func deleteAllChatsForUser(userId: String) async throws {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
    }

    func reportChat(report: ChatReportModel) async throws {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
    }

    private func tryShowError() throws {
        if showError {
            throw URLError(.unknown)
        }
    }
}
