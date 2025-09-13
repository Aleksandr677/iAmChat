//
//  ChatBubbleViewBuilder.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 13.09.2025.
//

import SwiftUI

struct ChatBubbleViewBuilder: View {
    
    var chatMessage: ChatMessageModel = .mock
    var isCurrentUser: Bool = false
    var imageName: String?
    
    var body: some View {
        ChatBubbleView(
            showImage: !isCurrentUser,
            textColor: isCurrentUser ? .white : .primary,
            backgroundColor: isCurrentUser ? .accent : Color(uiColor: .systemGray6),
            text: chatMessage.content ?? "",
            imageName: imageName
        )
        .frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
        .padding(.leading, isCurrentUser ? 75 : 0)
        .padding(.trailing, isCurrentUser ? 0 : 75)
    }
}

#Preview {
    ChatBubbleViewBuilder()
}
