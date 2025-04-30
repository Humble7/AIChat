//
//  FileManagerUserPersistance.swift
//  AIChat
//
//  Created by ChenZhen on 30/4/25.
//
import Foundation

struct FileManagerUserPersistance: LocalUserPersistance {
    private let userDocumentKey = "current_user"

    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userDocumentKey)
    }
    
    func saveCurrentUser(_ user: UserModel?) throws {
        try FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}
