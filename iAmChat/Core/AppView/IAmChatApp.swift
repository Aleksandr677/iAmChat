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
            EnviromentBuilderView {
                AppView()
            }
        }
    }
}

struct EnviromentBuilderView<Content: View>: View {
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .environment(AuthManager(service: FirebaseAuthService()))
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
