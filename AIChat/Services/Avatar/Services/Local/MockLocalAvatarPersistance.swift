//
//  MockLocalAvatarPersistance.swift
//  AIChat
//
//  Created by ChenZhen on 3/5/25.
//

import SwiftUI

@MainActor
struct MockLocalAvatarPersistance: LocalAvatarPersistence {
    func addRecentAvatar(avatar: AvatarModel) throws {

    }

    func getRecentAvatars() throws -> [AvatarModel] {
        AvatarModel.mocks.shuffled()
    }
}
