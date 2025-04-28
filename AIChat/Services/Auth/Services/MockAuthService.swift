//
//  MockAuthService.swift
//  AIChat
//
//  Created by ChenZhen on 27/4/25.
//
import Foundation

struct MockAuthService: AuthService {

    let currentUser: UserAuthInfo?

    init(user: UserAuthInfo? = nil) {
        self.currentUser = user
    }

    func getAuthenticatedUser() -> UserAuthInfo? {
        currentUser
    }

    func addAuthenticatedUserListener(onListenerAttached: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?> {
        AsyncStream { continuation in
            continuation.yield(currentUser)
        }
    }

    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: true)
        return (user, true)
    }

    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: true)
        return (user, false)
    }

    func signOut() throws {

    }

    func deleteAccount() async throws {

    }

}
