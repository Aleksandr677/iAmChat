//
//  HeroCellView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 04.09.2025.
//

import SwiftUI

struct HeroCellView: View {
    var title: String? = "This is some title"
    var subtitle: String? = "This is some subtitle"
    var image: String? = Constants.randomImageURL
    
    var body: some View {
        ZStack {
            if let imageURL = image {
                ImageLoaderView(urlString: imageURL)
            } else {
                Rectangle()
                    .fill(.accent)
            }
        }
        .overlay(alignment: .bottomLeading,
                 content: {
            VStack(alignment: .leading, spacing: 4) {
                if let title = title {
                    Text(title)
                        .font(.headline)
                }
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
            .foregroundStyle(.white)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .addingGradientBackgroundForText()
        })
        .cornerRadius(16)
    }
}

#Preview {
    ScrollView {
        HeroCellView()
            .frame(width: 300, height: 200)
        HeroCellView(image: nil)
            .frame(width: 300, height: 200)
        HeroCellView(title: nil)
            .frame(width: 300, height: 200)
        HeroCellView(subtitle: nil)
            .frame(width: 300, height: 200)
    }
}
