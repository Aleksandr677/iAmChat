//
//  ChatView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 13.09.2025.
//

import SwiftUI

struct ChatView: View {
    
    @State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
    @State private var avatar: AvatarModel? = .mock
    @State private var currentUser: UserModel? = .mock
    @State private var newMessageText: String = ""
    @State private var scrollPosition: String?
    @State private var showAlert: AnyAppAlert?
    @State private var showChatSettings: AnyAppAlert?
    
    var body: some View {
        VStack(spacing: 0) {
            scrollViewSection
            textFieldSection
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "ellipsis")
                    .padding(8)
                    .anyButton {
                        onChatSettingsPressed()
                    }
            }
        }
        .showCustomAlert(type: .confirmationDialog, alert: $showChatSettings)
        .showCustomAlert(alert: $showAlert)
    }
    
    private var scrollViewSection: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(chatMessages) { message in
                    let isCurrentUser = message.authorId == currentUser?.id
                    ChatBubbleViewBuilder(
                        chatMessage: message,
                        isCurrentUser: isCurrentUser,
                        imageName: isCurrentUser ? nil : avatar?.profileImageName
                    )
                    .id(message.id)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .rotationEffect(.degrees(180))
        }
        .rotationEffect(.degrees(180))
        .scrollPosition(id: $scrollPosition, anchor: .center)
        .animation(.default, value: chatMessages.count)
        .animation(.default, value: scrollPosition)
    }
    
    private var textFieldSection: some View {
        TextField("Say something...", text: $newMessageText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .padding(12)
            .padding(.trailing, 60)
            .overlay(alignment: .trailing,
                     content: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .padding(.trailing, 4)
                    .foregroundStyle(.accent)
                    .anyButton(option: .plain,
                               action: {
                        onSendMessagePressed()
                    })
            })
            .background(content: {
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(uiColor: .systemBackground))
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
            })
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(uiColor: .secondarySystemBackground))
    }
    
    private func onSendMessagePressed() {
        guard let currentUser else { return }
        let messageText = newMessageText
        do {
            try TextValidationHelper.checkIfTextIsValid(text: messageText)
            let message = ChatMessageModel(
                id: UUID().uuidString,
                chatId: UUID().uuidString,
                authorId: currentUser.id,
                content: messageText,
                seenByIds: nil,
                dateCreated: .now
            )
            chatMessages.append(message)
            scrollPosition = message.id
            newMessageText = ""
        } catch {
            showAlert = AnyAppAlert(error: error)
        }
    }
    
    private func onChatSettingsPressed() {
        showChatSettings = AnyAppAlert(title: "",
                                       subtitle: "What would you like to do?",
                                       buttons: {
            AnyView(
                Group(content: {
                    Button("Report User / Chat", role: .destructive, action: {})
                    Button("Delete Chat", role: .destructive, action: {})
                })
            )
        })
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
