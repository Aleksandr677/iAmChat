//
//  WelcomeView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var imageName = Constants.randomImageURL
    @State private var showSignInView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                ImageLoaderView(urlString: imageName)
                    .ignoresSafeArea()
                titleSection
                ctaButtons
                policyLinks
            }
        }
        .sheet(isPresented: $showSignInView) {
            CreateAccountView(title: "Sign In",
                              subtitle: "Connect to an existing account.")
                .presentationDetents([.medium])
        }
    }
    
    private var titleSection: some View {
        Text("i Am Chat 🫂")
            .font(.largeTitle)
            .fontWeight(.semibold)
    }
    
    private var ctaButtons: some View {
        VStack(spacing: 8) {
            NavigationLink(destination: {
                OnboardingIntroView()
            },
                           label: {
                Text("Get Started")
                    .callToActionButton()
            })
            
            Text("Already have an account? Sign in!")
                .underline()
                .font(.body)
                .padding(8)
                .tappableBackground()
                .onTapGesture {
                    onSingInPressed()
                }
        }
        .padding(16)
    }
    
    private func onSingInPressed() {
        showSignInView = true
    }
    
    private var policyLinks: some View {
        HStack(spacing: 8) {
            Link(destination: URL(string: Constants.termsOfServiceURL)!) {
                Text("Terms of Service")
            }
            Circle()
                .fill(.accent)
                .frame(width: 4, height: 4)
            Link(destination: URL(string: Constants.privacyPolicyURL)!) {
                Text("Privacy Policy")
            }
        }
    }
}

#Preview {
    WelcomeView()
}
