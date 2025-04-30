//
//  MockUserPersistance.swift
//  AIChat
//
//  Created by ChenZhen on 30/4/25.
//

struct MockUserPersistance: LocalUserPersistance {
    let currentUser: UserModel?

    init(user: UserModel? = nil) {
        self.currentUser = user
    }

    func getCurrentUser() -> UserModel? {
        currentUser
    }

    func saveCurrentUser(_ user: UserModel?) {

    }
}
