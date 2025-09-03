//
//  ImageLoaderView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SDWebImageSwiftUI
import SwiftUI

struct ImageLoaderView: View {
    var urlString: String = Constants.randomImageURL
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsTightening(false)
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
}
