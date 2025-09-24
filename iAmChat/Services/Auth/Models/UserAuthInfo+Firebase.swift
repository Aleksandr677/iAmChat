//
//  UserAuthInfo+Firebase.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 24.09.2025.
//

import FirebaseAuth

extension UserAuthInfo {
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
