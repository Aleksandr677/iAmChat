//
//  FirebaseUserService.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 10.10.2025.
//

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseUserService: RemoteUserService {
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(_ user: UserModel) async throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }
    
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.didCompleteOnboarding.rawValue: true,
            UserModel.CodingKeys.profileColorHex.rawValue: profileColorHex
        ])
    }
    
    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
}
