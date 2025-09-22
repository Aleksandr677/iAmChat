//
//  ChatsView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct ChatsView: View {
    
    @State private var chats: [ChatModel] = ChatModel.mocks
    
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List(
                content: {
                    ForEach(chats) { chat in
                        ChatRowCellViewBuilder(
                            chat: chat,
                            getAvatar: {
                                try? await Task.sleep(for: .seconds(1))
                                return AvatarModel.mocks.randomElement()!
                            },
                            getlastChatMessage: {
                                try? await Task.sleep(for: .seconds(1))
                                return ChatMessageModel.mocks.randomElement()!
                            },
                            currentUserId: nil // FIX ME
                        )
                        .anyButton(option: .highlight,
                                   action: {
                            onChatPressed(chatModel: chat)
                        })
                        .removeListRowFormatting()
                }
            })
            .navigationTitle("Chats")
            .navigationDestinationForCoreModule(path: $path)
        }
    }
    
    private func onChatPressed(chatModel: ChatModel) {
        path.append(.chat(avatarId: chatModel.avatarId))
    }
}

#Preview {
    ChatsView()
}
