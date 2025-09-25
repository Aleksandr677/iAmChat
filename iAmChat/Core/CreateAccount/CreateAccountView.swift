//
//  CreateAccountView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 08.09.2025.
//

import SwiftUI

struct CreateAccountView: View {
    
    var title: String = "Create Account?"
    var subtitle: String = "Don't lose your data! Connect to an SSO provider to save your account!"
    @Environment(\.authService) private var authService
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text(subtitle)
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            SignInWithAppleButtonView(
                type: .signIn,
                style: .black,
                cornerRadius: 10)
            .frame(height: 55)
            .anyButton(option: .press) {
                Task {
                    await signInUser()
                }
            }
            
            Spacer()
        }
        .padding(16)
        .padding(.top, 40)
    }
    
    private func signInUser() async {
        do {
            let result = try await authService.signInAnonymously()
            print("Sing in anonymously: \(result.user.uid)")
            dismiss.callAsFunction()
        } catch {
            print("DEBUG-1", error)
        }
    }
}

#Preview {
    CreateAccountView()
}
