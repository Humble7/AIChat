//
//  ChatMessageModel.swift
//  AIChat
//
//  Created by ChenZhen on 24/4/25.
//

import Foundation

struct ChatMessageModel {
    let id: String
    let chatId: String
    let authorId: String?
    let content: String?
    let seenByIds: [String]?
    let dateCreated: Date?

    init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: String? = nil,
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

    static var mock: Self {
        mocks[0]
    }

    static var mocks: [Self] {
        return [
            ChatMessageModel(
                id: "msg1",
                chatId: "chat001",
                authorId: "user001",
                content: "Hey, how's it going?",
                seenByIds: ["user002", "user003"],
                dateCreated: Date.now.addingTimeInterval(minutes: -30)
            ),
            ChatMessageModel(
                id: "msg2",
                chatId: "chat001",
                authorId: "user002",
                content: "Pretty good! You?",
                seenByIds: ["user001"],
                dateCreated: Date.now.addingTimeInterval(minutes: -25)
            ),
            ChatMessageModel(
                id: "msg3",
                chatId: "chat002",
                authorId: "user003",
                content: "Wanna grab lunch later?",
                seenByIds: [],
                dateCreated: Date.now.addingTimeInterval(hours: -1)
            ),
            ChatMessageModel(
                id: "msg4",
                chatId: "chat003",
                authorId: "user004",
                content: "Sure, let's go to the new sushi place.",
                seenByIds: ["user003"],
                dateCreated: Date.now
            )
        ]
    }
}
