//
//  SettingsView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    
    var body: some View {
        NavigationStack {
            List {
                Button(action: {
                    onSingOutPressed()
                },
                       label: {
                    Text("Sign out")
                })
            }
            .navigationTitle("Settings")
        }
    }
    
    func onSingOutPressed() {
        dismiss()
        Task {
            try? await Task.sleep(for: .seconds(0.5))
            appState.updateViewState(showTabBarView: false)
        }
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
