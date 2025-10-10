//
//  RemoteUserService.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 10.10.2025.
//

protocol RemoteUserService: Sendable {
    func saveUser(_ user: UserModel) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws
}
