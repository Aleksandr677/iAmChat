//
//  UserManager.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 27.09.2025.
//

import SwiftUI

protocol UserService: Sendable {
    func saveUser(_ user: UserModel) async throws
}

import FirebaseFirestore

struct FirebaseUserService: UserService {
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(_ user: UserModel) async throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }
}

@MainActor
@Observable
class UserManager {
    private(set) var currentUser: UserModel?
    private let service: UserService
    
    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion: String? = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        
        try await service.saveUser(user)
    }
}
