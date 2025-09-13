//
//  ChatBubbleView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 13.09.2025.
//

import SwiftUI

struct ChatBubbleView: View {
    var showImage: Bool = true
    var textColor: Color = .primary
    var backgroundColor: Color = Color(uiColor: .systemGray6)
    var text: String = "This is sample text"
    var imageName: String?
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if showImage {
                ZStack {
                    if let imageName {
                        ImageLoaderView(urlString: imageName)
                    } else {
                        Rectangle()
                            .fill(.secondary)
                    }
                }
                .frame(width: 45, height: 45)
                .clipShape(.circle)
                .offset(y: 10)
            }
            
            Text(text)
                .font(.body)
                .foregroundStyle(textColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(backgroundColor)
                .cornerRadius(10)
        }
        .padding(.bottom, showImage ? 10 : 0)
    }
}

#Preview {
    ScrollView {
        VStack(alignment: .center, spacing: 16) {
            ChatBubbleView()
            ChatBubbleView()
            ChatBubbleView()
        }
    }
}
