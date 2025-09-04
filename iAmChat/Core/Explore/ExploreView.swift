//
//  ExploreView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct ExploreView: View {
    
    let avatar = AvatarModel.mock
    @State private var featuredAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    
    var body: some View {
        NavigationStack {
            List(content: {
                featuredSection
                categorySection
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
                }
            })
            .removeListRowFormatting()
        },
                header: {
            Text("Featured Avatars")
        })
    }
    
    private var categorySection: some View {
        Section(content: {
            ZStack(content: {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            CategoryCellView(title: category.rawValue.capitalized,
                                             imageName: Constants.randomImageURL)
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
}

#Preview {
    ExploreView()
}
