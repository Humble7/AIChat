//
//  LocalAvatarPersistence.swift
//  AIChat
//
//  Created by ChenZhen on 3/5/25.
//

import SwiftUI

@MainActor
protocol LocalAvatarPersistence: Sendable {
    func addRecentAvatar(avatar: AvatarModel) throws
    func getRecentAvatars() throws -> [AvatarModel]
}
