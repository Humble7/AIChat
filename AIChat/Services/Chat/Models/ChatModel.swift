//
//  ChatModel.swift
//  AIChat
//
//  Created by ChenZhen on 24/4/25.
//

import Foundation

struct ChatModel: Identifiable {
    let id: String
    let userId: String
    let avatarId: String
    let dateCreated: Date
    let dataModified: Date

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
                dataModified: Date.now.addingTimeInterval(hours: -2)
            ),
            ChatModel(
                id: "mock_chat_2",
                userId: "user002",
                avatarId: "avatar002",
                dateCreated: Date.now.addingTimeInterval(days: -10),
                dataModified: Date.now.addingTimeInterval(hours: -12)
            ),
            ChatModel(
                id: "mock_chat_3",
                userId: "user003",
                avatarId: "avatar003",
                dateCreated: Date.now.addingTimeInterval(days: -1),
                dataModified: Date.now.addingTimeInterval(minutes: -30)
            ),
            ChatModel(
                id: "mock_chat_4",
                userId: "user004",
                avatarId: "avatar004",
                dateCreated: Date.now,
                dataModified: Date.now
            )
        ]
    }
}
