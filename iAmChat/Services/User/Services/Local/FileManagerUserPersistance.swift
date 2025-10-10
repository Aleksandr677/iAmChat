//
//  FileManagerUserPersistance.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 10.10.2025.
//

import Foundation

struct FileManagerUserPersistance: LocalUserPersistance {
    
    private let userDocumentKey = "current_user"
    
    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userDocumentKey)
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        try FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}
