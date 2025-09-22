//
//  CategoryListView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 18.09.2025.
//

import SwiftUI

struct CategoryListView: View {
    @Binding var path: [NavigationPathOption]
    var category: CharacterOption = .alien
    var imageName: String = Constants.randomImageURL
    @State private var avatars: [AvatarModel] = AvatarModel.mocks
    
    var body: some View {
        List {
            CategoryCellView(
                title: category.plural.capitalized,
                imageName: imageName,
                font: .largeTitle,
                cornerRadius: 0
            )
            .removeListRowFormatting()
            
            ForEach(avatars, id: \.self) { avatar in
                CustomListCell(
                    imageName: avatar.profileImageName,
                    title: avatar.name,
                    subtitle: avatar.characterDescription
                )
                .anyButton(option: .highlight,
                           action: {
                    onAvatarPressed(avatar: avatar)
                })
                .removeListRowFormatting()
            }
        }
        .ignoresSafeArea()
        .listStyle(.plain)
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
}

#Preview {
    CategoryListView(path: .constant([]))
}
