//
//  RemoteUserService.swift
//  AIChat
//
//  Created by ChenZhen on 30/4/25.
//

protocol RemoteUserService: Sendable {
    func saveUser(user: UserModel) async throws
    func markOnBoardingCompleted(userId: String, profileColorHex: String) async throws
    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
}
