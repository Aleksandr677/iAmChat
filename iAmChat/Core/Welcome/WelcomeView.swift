//
//  WelcomeView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                    .frame(maxHeight: .infinity)
                
                NavigationLink(destination: {
                    OnboardingCompletedView()
                },
                               label: {
                    Text("Get Started")
                        .callToActionButton()
                })
            }
            .padding(16)
        }
    }
}

#Preview {
    WelcomeView()
}
