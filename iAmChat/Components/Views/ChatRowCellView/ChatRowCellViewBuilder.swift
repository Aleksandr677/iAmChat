//
//  ChatRowCellViewBuilder.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 05.09.2025.
//

import SwiftUI

struct ChatRowCellViewBuilder: View {
    
    var chat: ChatModel = ChatModel.mock
    var getAvatar: () async -> AvatarModel?
    var getlastChatMessage: () async -> ChatMessageModel?
    @State private var avatar: AvatarModel?
    @State private var lastChatMessage: ChatMessageModel?
    @State private var didLoadAvatar: Bool = false
    @State private var didLoadLastChatMessage: Bool = false
    
    private var isLoading: Bool {
        if didLoadAvatar && didLoadLastChatMessage {
            return false
        }
        return true
    }
    
    private var hasNewChat: Bool {
        guard let lastChatMessage, let currentUserId else { return false }
        return lastChatMessage.hasBeenSeenBy(userId: currentUserId)
    }
    
    private var subheadline: String? {
        if isLoading {
            return "xxxx xxxx xxxx"
        }
        if avatar == nil && lastChatMessage == nil {
            return "Error loading data."
        }
        return lastChatMessage?.content
    }
    
    var currentUserId: String? = ""
    
    var body: some View {
        ChatRowCellView(
            imageName: avatar?.profileImageName,
            headline: isLoading ? "xxxx xxxx" : avatar?.name,
            subheadline: subheadline,
            hasNewChat: isLoading ? false : hasNewChat
        )
        .redacted(reason: isLoading ? .placeholder : [])
        .task {
            avatar = await getAvatar()
            didLoadAvatar = true
        }
        .task {
            lastChatMessage = await getlastChatMessage()
            didLoadLastChatMessage = true
        }
    }
}

#Preview {
    VStack {
        ChatRowCellViewBuilder(chat: .mock,
                               getAvatar: {
            return .mock
        },
                               getlastChatMessage: {
            return .mock
        })
        
        ChatRowCellViewBuilder(chat: .mock,
                               getAvatar: {
            try? await Task.sleep(for: .seconds(5))
            return .mock
        },
                               getlastChatMessage: {
            try? await Task.sleep(for: .seconds(5))
            return .mock
        })
    }
}
