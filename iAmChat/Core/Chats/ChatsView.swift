//
//  ChatsView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct ChatsView: View {
    
    @State private var chats: [ChatModel] = ChatModel.mocks
    @State private var recentAvatars: [AvatarModel] = AvatarModel.mocks
    
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List(content: {
                if !recentAvatars.isEmpty {
                    recentsSection
                }
                chatsSection
            })
            .navigationTitle("Chats")
            .navigationDestinationForCoreModule(path: $path)
        }
    }
    
    private func onChatPressed(chatModel: ChatModel) {
        path.append(.chat(avatarId: chatModel.avatarId))
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
    
    private var chatsSection: some View {
        Section(content: {
            if chats.isEmpty {
                Text("Your chats will appear here!")
                    .foregroundStyle(.secondary)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(40)
                    .removeListRowFormatting()
            } else {
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
            }
        }, header: {
            Text("Chats")
        })
    }
    
    private var recentsSection: some View {
        Section {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(recentAvatars, id: \.self) { avatar in
                        if let avatarImage = avatar.profileImageName {
                            VStack(spacing: 8) {
                                ImageLoaderView(urlString: avatarImage)
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipShape(.circle)
                                
                                Text(avatar.name ?? "")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .anyButton {
                                onAvatarPressed(avatar: avatar)
                            }
                        }
                    }
                }
                .padding(.top, 12)
            }
            .frame(height: 120)
            .scrollIndicators(.hidden)
            .removeListRowFormatting()
        } header: {
            Text("Recents")
        }
    }
}

#Preview {
    ChatsView()
}
