//
//  ChatModel.swift
//  AIChat
//
//  Created by ChenZhen on 24/4/25.
//

import Foundation
import IdentifiableByString

struct ChatModel: Identifiable, Codable, Hashable, StringIdentifiable {
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

    static func chatId(userId: String, avatarId: String) -> String {
        "\(userId)_\(avatarId)"
    }

    static func new(userId: String, avatarId: String) -> Self {
        ChatModel(
            id: chatId(userId: userId, avatarId: avatarId),
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
                userId: UserAuthInfo.mock().uid,
                avatarId: AvatarModel.mocks.randomElement()!.avatarId,
                dateCreated: Date.now.addingTimeInterval(days: -3),
                dateModified: Date.now.addingTimeInterval(hours: -2)
            ),
            ChatModel(
                id: "mock_chat_2",
                userId: UserAuthInfo.mock().uid,
                avatarId: AvatarModel.mocks.randomElement()!.avatarId,
                dateCreated: Date.now.addingTimeInterval(days: -10),
                dateModified: Date.now.addingTimeInterval(hours: -12)
            ),
            ChatModel(
                id: "mock_chat_3",
                userId: UserAuthInfo.mock().uid,
                avatarId: AvatarModel.mocks.randomElement()!.avatarId,
                dateCreated: Date.now.addingTimeInterval(days: -1),
                dateModified: Date.now.addingTimeInterval(minutes: -30)
            ),
            ChatModel(
                id: "mock_chat_4",
                userId: UserAuthInfo.mock().uid,
                avatarId: AvatarModel.mocks.randomElement()!.avatarId,
                dateCreated: Date.now,
                dateModified: Date.now
            )
        ]
    }
}
