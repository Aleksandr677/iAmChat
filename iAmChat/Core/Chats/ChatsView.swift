//
//  ChatsView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct ChatsView: View {
    
    @State private var chats: [ChatModel] = ChatModel.mocks
    
    var body: some View {
        NavigationStack {
            List(
                content: {
                    ForEach(chats) { chat in
                        ChatRowCellViewBuilder(
                            chat: chat,
                            getAvatar: {
                                try? await Task.sleep(for: .seconds(1))
                                return .mock
                            },
                            getlastChatMessage: {
                                try? await Task.sleep(for: .seconds(1))
                                return .mock
                            },
                            currentUserId: nil // FIX ME
                        )
                        .anyButton(option: .highlight, action: {
                            
                        })
                        .removeListRowFormatting()
                }
            })
            .navigationTitle("Chats")
        }
    }
}

#Preview {
    ChatsView()
}
