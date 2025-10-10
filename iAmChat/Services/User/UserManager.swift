//
//  UserManager.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 27.09.2025.
//

import SwiftUI

@MainActor
@Observable
class UserManager {
    private(set) var currentUser: UserModel?
    private let remote: RemoteUserService
    private let local: LocalUserPersistance
    
    init(services: UserServices) {
        self.remote = services.remote
        self.local = services.local
        self.currentUser = local.getCurrentUser()
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion: String? = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        
        try await remote.saveUser(user)
        addCurrentUserListener(userId: auth.uid)
    }
    
    private func addCurrentUserListener(userId: String) {
        Task {
            do {
                for try await value in remote.streamUser(userId: userId) {
                    self.currentUser = value
                    self.saveCurrentUserLocally()
                    print("Successfully got user: \(value.userId)")
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    private func saveCurrentUserLocally() {
        Task {
            do {
                try local.saveCurrentUser(user: currentUser)
                print("Success saving user locally")
            } catch {
                print("Error saving user locally: \(error)")
            }
        }
    }
    
    func markOnboardingCompleteForCurrentUser(profileColorHex: String) async throws {
        try await remote.markOnboardingCompleted(userId: currentUserId(),
                                                  profileColorHex: profileColorHex)
    }
    
    func signOut() {
        currentUser = nil
    }
    
    func deleteUser() async throws {
        try await remote.deleteUser(userId: self.currentUserId())
        signOut()
    }
    
    private func currentUserId() throws -> String {
        guard let uid = currentUser?.userId else { throw UserManagerError.noUserId }
        return uid
    }
    
    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
