//
//  SettingsView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    @Environment(AppState.self) private var appState
    @State private var isPremium: Bool = true
    @State private var isAnonymousUser: Bool = true
    @State private var showCreateAccountView: Bool = false
    @State private var showAlert: AnyAppAlert?
    
    var body: some View {
        NavigationStack {
            List {
                accountSection
                purchaseSection
                applicationSection
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showCreateAccountView,
                   onDismiss: {
                setAnonymousAccountStatus()
            },
                   content: {
                CreateAccountView()
                    .presentationDetents([.medium])
            })
            .onAppear {
                setAnonymousAccountStatus()
            }
            .showCustomAlert(alert: $showAlert)
        }
    }
    
    func setAnonymousAccountStatus() {
        isAnonymousUser = authManager.auth?.isAnonymous == true
    }
    
    func onSingOutPressed() {
        Task {
            do {
                try authManager.signOut()
                userManager.signOut()
                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
        }
    }
    
    private func dismissScreen() async {
        dismiss()
        try? await Task.sleep(for: .seconds(0.5))
        appState.updateViewState(showTabBarView: false)
    }
    
    func onCreateAccountPressed() {
        showCreateAccountView = true
    }
    
    func onDeleteAccountPressed() {
        showAlert = AnyAppAlert(title: "Delete account?",
                                subtitle: "This action is perminent and cannot be undone. You will lose all your data.",
                                buttons: {
            AnyView(
                Button("Delete",
                       role: .destructive,
                       action: {
                           onDeleteAccountConfirmed()
                       })
            )
        })
    }
    
    private func onDeleteAccountConfirmed() {
        Task {
            do {
                try await authManager.deleteAccount()
                try await userManager.deleteUser()
                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
        }
    }
    
    private var accountSection: some View {
        Section(content: {
            if isAnonymousUser {
                Text("Save & back-up account")
                    .rowFormatting()
                    .anyButton(option: .highlight) {
                        onCreateAccountPressed()
                    }
                    .removeListRowFormatting()
            } else {
                Text("Sign out")
                    .rowFormatting()
                    .anyButton(option: .highlight) {
                        onSingOutPressed()
                    }
                    .removeListRowFormatting()
            }
            
            Text("Delete account")
                .foregroundStyle(.red)
                .rowFormatting()
                .anyButton(option: .highlight) {
                    onDeleteAccountPressed()
                }
                .removeListRowFormatting()
        },
                header: {
            Text("Account")
        })
    }
    
    private var purchaseSection: some View {
        Section(content: {
            HStack(spacing: 8) {
                Text("Account status: \(isPremium ? "Premium" : "FREE")")
                Spacer(minLength: 0)
                if isPremium {
                    Text("MANAGE")
                        .badgeButton()
                }
            }
            .rowFormatting()
            .anyButton(option: .highlight) {
                
            }
            .disabled(!isPremium)
            .removeListRowFormatting()
        },
                header: {
            Text("Purchases")
        })
    }
    
    private var applicationSection: some View {
        Section(content: {
            HStack(spacing: 8) {
                Text("Version")
                Spacer(minLength: 0)
                Text(Utilities.appVersion ?? "")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            .removeListRowFormatting()
            
            HStack(spacing: 8) {
                Text(Utilities.buildNumber ?? "")
                Spacer(minLength: 0)
                Text("1")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            .removeListRowFormatting()
            
            Text("Contact us")
                .foregroundStyle(.blue)
                .rowFormatting()
                .anyButton(option: .highlight,
                           action: {
                    
                })
                .removeListRowFormatting()
        },
                header: {
            Text("Application")
        })
    }
}

fileprivate extension View {
    func rowFormatting() -> some View {
        self
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color(uiColor: .systemBackground))
    }
}

#Preview {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: .mock())))
        .environment(AppState())
        .environment(UserManager(services: MockUserServices(user: nil)))
}
