//
//  ChatMessageModel.swift
//  AIChat
//
//  Created by ChenZhen on 24/4/25.
//

import Foundation

struct ChatMessageModel: Identifiable, Codable {
    let id: String
    let chatId: String
    let authorId: String?
    let content: AIChatModel?
    let seenByIds: [String]?
    let dateCreated: Date?

    init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: AIChatModel? = nil,
        seenByIds: [String]? = nil,
        dateCreated: Date? = nil
    ) {
        self.id = id
        self.chatId = chatId
        self.authorId = authorId
        self.content = content
        self.seenByIds = seenByIds
        self.dateCreated = dateCreated
    }

    func hasBeenSeenBy(userId: String) -> Bool {
        guard let seenByIds else { return false }
        return seenByIds.contains(userId)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case chatId = "chat_id"
        case authorId = "author_id"
        case content
        case seenByIds = "seen_by_ids"
        case dateCreated = "date_created"
    }

    static func newUserMessage(chatId: String, userId: String, message: AIChatModel) -> Self {
        ChatMessageModel(
            id: UUID().uuidString,
            chatId: chatId,
            authorId: userId,
            content: message,
            seenByIds: [userId],
            dateCreated: .now
        )
    }

    static func newAIMessage(chatId: String, avatarId: String, message: AIChatModel) -> Self {
        ChatMessageModel(
            id: UUID().uuidString,
            chatId: chatId,
            authorId: avatarId,
            content: message,
            seenByIds: [],
            dateCreated: .now
        )
    }

    static var mock: Self {
        mocks[0]
    }

    static var mocks: [Self] {
        return [
            ChatMessageModel(
                id: "msg1",
                chatId: "chat001",
                authorId: UserAuthInfo.mock().uid,
                content: AIChatModel(role: .user, message: "Hey, how's it going?"),
                seenByIds: ["user002", "user003"],
                dateCreated: Date.now.addingTimeInterval(minutes: -30)
            ),
            ChatMessageModel(
                id: "msg2",
                chatId: "chat001",
                authorId: AvatarModel.mock.avatarId,
                content: AIChatModel(role: .assistant, message: "Pretty good! You?"),
                seenByIds: ["user001"],
                dateCreated: Date.now.addingTimeInterval(minutes: -25)
            ),
            ChatMessageModel(
                id: "msg3",
                chatId: "chat002",
                authorId: UserAuthInfo.mock().uid,
                content: AIChatModel(role: .user, message: "Wanna grab lunch later?"),
                seenByIds: [],
                dateCreated: Date.now.addingTimeInterval(hours: -1)
            ),
            ChatMessageModel(
                id: "msg4",
                chatId: "chat003",
                authorId: AvatarModel.mock.avatarId,
                content: AIChatModel(role: .assistant, message: "Sure, let's go to the new sushi place."),
                seenByIds: ["user003"],
                dateCreated: Date.now
            )
        ]
    }
}
