//
//  MockUserService.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 10.10.2025.
//

struct MockUserService: RemoteUserService {
    
    let currentUser: UserModel?
    
    init(user: UserModel? = nil) {
        self.currentUser = user
    }
    
    func saveUser(_ user: UserModel) async throws {
        
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, any Error> {
        AsyncThrowingStream { continuation in
            if let currentUser {
                continuation.yield(currentUser)
            }
        }
    }
    
    func deleteUser(userId: String) async throws {
        
    }
    
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {
        
    }
}
