//
//  ExploreView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct ExploreView: View {
    @State private var featuredAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    @State private var popular: [AvatarModel] = AvatarModel.mocks
    
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List(content: {
                featuredSection
                categorySection
                popularSection
            })
            .navigationTitle("Explore")
            .navigationDestinationForCoreModule(path: $path)
        }
    }
    
    private var featuredSection: some View {
        Section(content: {
            ZStack(content: {
                CarouselView(items: featuredAvatars) { item in
                    HeroCellView(title: item.name,
                                 subtitle: item.characterDescription,
                                 image: item.profileImageName)
                    .anyButton {
                        onAvatarPressed(avatar: item)
                    }
                }
            })
            .removeListRowFormatting()
        },
                header: {
            Text("Featured")
        })
    }
    
    private var categorySection: some View {
        Section(content: {
            ZStack(content: {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            if let imageName = popular.first(where: {
                                $0.characterOption == category
                            })?.profileImageName {
                                CategoryCellView(title: category.plural.capitalized,
                                                 imageName: imageName)
                                .anyButton(option: .plain,
                                           action: {
                                    onCategoryPressed(category: category,
                                                      imageName: imageName)
                                })
                                .frame(width: 150)
                            }
                        }
                    }
                }
                .frame(height: 140)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
            })
            .removeListRowFormatting()
        },
                header: {
            Text("Categories")
        })
    }
    
    private var popularSection: some View {
        Section(content: {
            ForEach(popular, id: \.self) { avatar in
                CustomListCell(imageName: avatar.profileImageName,
                               title: avatar.name,
                               subtitle: avatar.characterDescription)
                .anyButton(option: .highlight,
                           action: {
                    onAvatarPressed(avatar: avatar)
                })
                .removeListRowFormatting()
            }
        },
                header: {
            Text("Popular")
        })
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
    
    private func onCategoryPressed(category: CharacterOption, imageName: String) {
        path.append(.category(category: category,
                              imageName: imageName))
    }
}

#Preview {
    ExploreView()
}
