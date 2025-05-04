//
//  LocalUserPersistence.swift
//  AIChat
//
//  Created by ChenZhen on 30/4/25.
//

protocol LocalUserPersistence {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(_ user: UserModel?) throws
}
