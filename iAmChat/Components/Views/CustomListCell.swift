//
//  CustomListCell.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 04.09.2025.
//

import SwiftUI

struct CustomListCell: View {
    
    var imageName: String? = Constants.randomImageURL
    var title: String? = "Alpha"
    var subtitle: String? = "An alien that is in here"
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                if let imageName = imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(.secondary.opacity(0.5))
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 60)
            .cornerRadius(16)
            
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
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .padding(.vertical, 4)
        .background(Color(uiColor: .systemBackground))
    }
}

#Preview {
    CustomListCell()
}
