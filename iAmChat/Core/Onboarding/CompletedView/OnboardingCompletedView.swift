//
//  OnboardingCompletedView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct OnboardingCompletedView: View {
    
    @Environment(AppState.self) private var root
    @State private var isCompletingProfileSetup: Bool = false
    var selectedColor: Color = .orange
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Setup complete!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(selectedColor)
            
            Text("We've set up your profile and you're ready to start chatting.")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom,
                       content: {
            ctaButton
        })
        .padding(24)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var ctaButton: some View {
        AsyncCallToActionButton(isLoading: isCompletingProfileSetup,
                                buttonTitle: "Finish",
                                action: onFinishButtonPressed)
    }
    
    func onFinishButtonPressed() {
        isCompletingProfileSetup = true
        Task {
            try await Task.sleep(for: .seconds(3))
            //try await saveUserProfile(color: selectedColor)
            isCompletingProfileSetup = false
            root.updateViewState(showTabBarView: true)
        }
    }
}

#Preview {
    OnboardingCompletedView(selectedColor: .mint)
        .environment(AppState())
}
