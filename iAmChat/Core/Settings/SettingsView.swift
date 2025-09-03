//
//  SettingsView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct SettingsView: View {
    
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
        appState.updateViewState(showTabBarView: false)
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
