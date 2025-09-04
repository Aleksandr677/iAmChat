//
//  CategoryCellView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 04.09.2025.
//

import SwiftUI

struct CategoryCellView: View {
    
    var title: String = "Aliens"
    var imageName: String = Constants.randomImageURL
    var font: Font = .title2
    var cornerRadius: CGFloat = 16
    
    var body: some View {
        ImageLoaderView(urlString: imageName)
            .aspectRatio(1, contentMode: .fit)
            .overlay(alignment: .bottomLeading, content: {
                Text(title)
                    .font(font)
                    .fontWeight(.semibold)
                    .padding(16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .addingGradientBackgroundForText()
            })
            .cornerRadius(cornerRadius)
    }
}

#Preview {
    CategoryCellView()
        .frame(width: 150)
}
