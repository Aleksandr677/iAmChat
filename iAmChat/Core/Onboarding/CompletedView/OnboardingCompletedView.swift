//
//  OnboardingCompletedView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct OnboardingCompletedView: View {
    
    @Environment(AppState.self) private var root
    
    var body: some View {
        VStack {
            Text("Onboarding completed")
                .frame(maxHeight: .infinity)
            
            Button(action: {
                onFinishButtonPressed()
            },
                   label: {
                Text("Finish")
                    .callToActionButton()
                    
            })
        }
        .padding(16)
    }
    
    func onFinishButtonPressed() {
        root.updateViewState(showTabBarView: true)
    }
}

#Preview {
    OnboardingCompletedView()
        .environment(AppState())
}
