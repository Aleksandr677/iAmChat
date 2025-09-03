//
//  ProfileView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var showSettingsView: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("Profile")
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsButton
                    }
                }
        }
        .sheet(isPresented: $showSettingsView) {
            Text("Settings")
        }
    }
    
    private var settingsButton: some View {
        Button(action: {
            onSettingsButtonPressed()
        },
               label: {
            Image(systemName: "gear")
                .font(.headline)
        })
    }
    
    private func onSettingsButtonPressed() {
        showSettingsView = true
    }
}

#Preview {
    ProfileView()
}
