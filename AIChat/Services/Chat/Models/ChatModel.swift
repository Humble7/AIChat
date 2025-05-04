//
//  ChatModel.swift
//  AIChat
//
//  Created by ChenZhen on 24/4/25.
//

import Foundation

struct ChatModel: Identifiable, Codable {
    let id: String
    let userId: String
    let avatarId: String
    let dateCreated: Date
    let dateModified: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case avatarId = "avatar_id"
        case dateCreated = "date_created"
        case dateModified = "date_modified"
    }

    static func new(userId: String, avatarId: String) -> Self {
        ChatModel(
            id: "\(userId)_\(avatarId)",
            userId: userId,
            avatarId: avatarId,
            dateCreated: .now,
            dateModified: .now
        )
    }

    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        return [
            ChatModel(
                id: "mock_chat_1",
                userId: "user001",
                avatarId: "avatar001",
                dateCreated: Date.now.addingTimeInterval(days: -3),
                dateModified: Date.now.addingTimeInterval(hours: -2)
            ),
            ChatModel(
                id: "mock_chat_2",
                userId: "user002",
                avatarId: "avatar002",
                dateCreated: Date.now.addingTimeInterval(days: -10),
                dateModified: Date.now.addingTimeInterval(hours: -12)
            ),
            ChatModel(
                id: "mock_chat_3",
                userId: "user003",
                avatarId: "avatar003",
                dateCreated: Date.now.addingTimeInterval(days: -1),
                dateModified: Date.now.addingTimeInterval(minutes: -30)
            ),
            ChatModel(
                id: "mock_chat_4",
                userId: "user004",
                avatarId: "avatar004",
                dateCreated: Date.now,
                dateModified: Date.now
            )
        ]
    }
}
