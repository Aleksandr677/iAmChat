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
            List(content: {
                ForEach(chats) { chat in
                    
                }
            })
            .navigationTitle("Chats")
        }
    }
}

#Preview {
    ChatsView()
}
