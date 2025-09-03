//
//  OnboardingIntroView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct OnboardingIntroView: View {
    var body: some View {
        VStack {
            Group(content: {
                Text("Make your own ")
                +
                Text("avatars ")
                    .foregroundStyle(.accent)
                    .fontWeight(.semibold)
                +
                Text("and chat with them!\n\nHave ")
                +
                Text("real conversations ")
                    .foregroundStyle(.accent)
                    .fontWeight(.semibold)
                +
                Text("with AI generated response.")
            })
            .baselineOffset(6)
            .frame(maxHeight: .infinity)
            .padding(24)
            
            NavigationLink(destination: {
                OnboardingColorView()
            },
                           label: {
                Text("Continue")
                    .callToActionButton()
            })
        }
        .padding(24)
        .font(.title3)
    }
}

#Preview {
    NavigationStack {
        OnboardingIntroView()
    }
}
