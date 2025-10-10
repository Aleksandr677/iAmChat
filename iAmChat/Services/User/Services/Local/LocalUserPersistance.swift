//
//  LocalUserPersistance.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 10.10.2025.
//

protocol LocalUserPersistance {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel?) throws
}
