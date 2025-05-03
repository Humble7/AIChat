//
//  AvatarManager.swift
//  AIChat
//
//  Created by ChenZhen on 1/5/25.
//

import Foundation
import SwiftUI

@MainActor
@Observable
class AvatarManager {

    private let remote: RemoteAvatarService
    private let local: LocalAvatarPersistence

    init(remote: RemoteAvatarService, local: LocalAvatarPersistence = MockLocalAvatarPersistance()) {
        self.remote = remote
        self.local = local
    }

    func addRecentAvatar(avatar: AvatarModel) throws {
        try local.addRecentAvatar(avatar: avatar)
    }

    func getRecentAvatars() throws -> [AvatarModel] {
        try local.getRecentAvatars()
    }

    func getAvatar(id: String) async throws -> AvatarModel {
        try await remote.getAvatar(id: id)
    }

    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {
        try await remote.createAvatar(avatar: avatar, image: image)
    }

    func getFeaturedAvatars() async throws -> [AvatarModel] {
        try await remote.getFeaturedAvatars()
    }

    func getPopularAvatars() async throws -> [AvatarModel] {
        try await remote.getPopularAvatars()
    }

    func getAvatarsForCategory(category: CharacterOption) async throws -> [AvatarModel] {
        try await remote.getAvatarsForCategory(category: category)
    }

    func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] {
        try await remote.getAvatarsForAuthor(userId: userId)
    }
}
