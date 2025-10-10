//
//  iAmChatApp.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 02.09.2025.
//

import SwiftUI
import FirebaseCore

@main
struct IAmChatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(delegate.authManager)
                .environment(delegate.userManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var authManager: AuthManager!
    var userManager: UserManager!
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        authManager = AuthManager(service: FirebaseAuthService())
        userManager = UserManager(services: ProductionUserServices())
        return true
    }
}
