//
//  ModalSupportView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 16.09.2025.
//

import SwiftUI

struct ModalSupportView<T: View>: View {
    
    @Binding var showModal: Bool
    @ViewBuilder var content: T
    
    var body: some View {
        ZStack {
            if showModal {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .transition(AnyTransition.opacity.animation(.smooth))
                    .onTapGesture {
                        showModal = false
                    }
                    .zIndex(1)
                
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .zIndex(2)
            }
        }
        .zIndex(9999)
        .animation(.bouncy, value: showModal)
    }
}

extension View {
    func showModal(showModal: Binding<Bool>,
                   @ViewBuilder content: () -> some View) -> some View {
        self
            .overlay {
                ModalSupportView(showModal: showModal,
                                 content: content)
            }
    }
}

private struct PreviewView: View {
    
    @State private var showModal: Bool = false
    
    var body: some View {
        Button(action: { showModal.toggle() },
               label: { Text("Click") })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .showModal(showModal: $showModal, content: { Text("Hello, World!") })
    }
}

#Preview {
    PreviewView()
}
