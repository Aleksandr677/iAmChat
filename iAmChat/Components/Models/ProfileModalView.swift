//
//  ProfileModalView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 15.09.2025.
//

import SwiftUI

struct ProfileModalView: View {
    
    var imageName: String? = Constants.randomImageURL
    var title: String? = "Alpha"
    var subtitle: String? = "Alien"
    var headline: String? = "An alien in the park."
    var onClose: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if let imageName {
                ImageLoaderView(urlString: imageName,
                                forceTransitionAnimation: true)
                    .aspectRatio(1, contentMode: .fit)
            }
            
            VStack(alignment: .leading,
                   spacing: 4) {
                if let title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                
                if let subtitle {
                    Text(subtitle)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                
                if let headline {
                    Text(headline)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
                   .padding(24)
                   .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.thinMaterial)
        .cornerRadius(16)
        .overlay(alignment: .topTrailing) {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundStyle(Color.black)
                .padding(4)
                .tappableBackground()
                .anyButton(action: {
                    onClose()
                })
                .padding(8)
        }
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        ProfileModalView()
            .padding(40)
    }
}
