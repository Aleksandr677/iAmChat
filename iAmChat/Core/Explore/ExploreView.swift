//
//  ExploreView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 03.09.2025.
//

import SwiftUI

struct ExploreView: View {
    
    let avatar = AvatarModel.mock
    
    var body: some View {
        NavigationStack {
            HeroCellView(
                title: avatar.name,
                subtitle: avatar.characterDescription,
                image: avatar.profileImageName
            )
                .navigationTitle("Explore")
        }
    }
}

#Preview {
    ExploreView()
}
