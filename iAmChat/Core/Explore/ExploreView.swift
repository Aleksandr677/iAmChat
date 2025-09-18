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
    
    var body: some View {
        NavigationStack {
            List(content: {
                featuredSection
                categorySection
                popularSection
            })
            .navigationTitle("Explore")
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
                            CategoryCellView(title: category.plural.capitalized,
                                             imageName: Constants.randomImageURL)
                            .anyButton(option: .plain, action: {})
                            .frame(width: 150)
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
                .anyButton(option: .highlight, action: {})
                .removeListRowFormatting()
            }
        },
                header: {
            Text("Popular")
        })
    }
}

#Preview {
    ExploreView()
}
