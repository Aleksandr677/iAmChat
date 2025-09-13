//
//  AsyncCallToActionButton.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 12.09.2025.
//

import SwiftUI

struct AsyncCallToActionButton: View {
    
    var isLoading: Bool = false
    var buttonTitle: String = "Save"
    var action: () -> Void
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(buttonTitle)
            }
        }
        .callToActionButton()
        .anyButton(option: .press,
                   action: {
            action()
        })
        .disabled(isLoading)
    }
}

#Preview {
    AsyncCallToActionButton(buttonTitle: "Finish",
                            action: {
        
    })
    .padding()
}
