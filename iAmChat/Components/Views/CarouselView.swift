//
//  CarouselView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 04.09.2025.
//

import SwiftUI

struct CarouselView<T: Hashable, Content: View>: View {
    
    var items: [T]
    @State private var selection: T?
    @ViewBuilder var content: (T) -> Content
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        content(item)
                            .scrollTransition(.interactive.threshold(.visible(0.95)),
                                              transition: { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1 : 0.9)
                            })
                            .containerRelativeFrame(.horizontal, alignment: .center)
                            .id(item)
                    }
                }
            }
            .frame(height: 200)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $selection)
            .onChange(of: items.count, { _, _ in
                updateSelectionIFNeeded()
            })
            .onAppear {
                updateSelectionIFNeeded()
            }
            
            HStack(alignment: .center, spacing: 8) {
                ForEach(items, id: \.self) { item  in
                    Circle()
                        .fill(item == selection ? .accent : .secondary.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
            .animation(.linear, value: selection)
        }
    }
    
    private func updateSelectionIFNeeded() {
        if selection == nil || selection == items.last {
            selection = items.first
        }
    }
}

#Preview {
    CarouselView(items: AvatarModel.mocks) { item in
        HeroCellView(
            title: item.name,
            subtitle: item.characterDescription,
            image: item.profileImageName
        )
    }
}
