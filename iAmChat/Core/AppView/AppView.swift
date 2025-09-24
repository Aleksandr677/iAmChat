//
//  AppView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 02.09.2025.
//

import SwiftUI

struct AppView: View {
    @Environment(\.authService) private var authService
    @State var appState: AppState = AppState()
    
    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            }
        )
        .environment(appState)
        .task {
            await checkUserStatus()
        }
    }
    
    private func checkUserStatus() async {
        if let user = authService.getAuthenticatedUser() {
            print("User signed in: \(user.uid)")
        } else {
            do {
                let result = try await authService.signInAnonymously()
                print("Sing in anonymously: \(result.user.uid)")
            } catch {
                print("DEBUG-1", error)
            }
        }
    }
}

#Preview("AppView - TabBar") {
    AppView(appState: .init(showTabBar: true))
}
#Preview("AppView - Onboarding") {
    AppView(appState: .init(showTabBar: false))
}
