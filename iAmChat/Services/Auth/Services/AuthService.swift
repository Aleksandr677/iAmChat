//
//  AuthService.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 25.09.2025.
//

import SwiftUI

protocol AuthService: Sendable {
    func getAuthenticatedUser() -> UserAuthInfo?
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signOut() throws
    func deleteAccount() async throws
}

extension EnvironmentValues {
    @Entry var authService: AuthService = MockAuthService()
}
