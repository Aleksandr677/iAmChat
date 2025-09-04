//
//  ButtonViewModifiers.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 04.09.2025.
//

import SwiftUI

struct HighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                configuration.isPressed ? Color.accent.opacity(0.4) : Color.accent.opacity(0)
            }
            .animation(.smooth, value: configuration.isPressed)
            
    }
}

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth, value: configuration.isPressed)
            
    }
}

enum ButtonStyleOption {
    case press, highlight, plain
}

extension View {
    
    @ViewBuilder
    func anyButton(option: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
        switch option {
        case .press:
            self.pressableButton(action: action)
        case .highlight:
            self.highlightButton(action: action)
        case .plain:
            self.plainButton(action: action)
        }
    }
    
    private func plainButton(action: @escaping () -> Void) -> some View {
        Button(action: action,
               label: {
            self
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    private func highlightButton(action: @escaping () -> Void) -> some View {
        Button(action: action,
               label: {
            self
        })
        .buttonStyle(HighlightButtonStyle())
    }
    
    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button(action: action,
               label: {
            self
        })
        .buttonStyle(PressableButtonStyle())
    }
}

#Preview {
    Text("New Button")
        .padding()
        .frame(maxWidth: .infinity)
        .anyButton(option: .highlight, action: {})
    
    Text("New Button2")
        .padding()
        .frame(maxWidth: .infinity)
        .callToActionButton()
        .anyButton(option: .press, action: {})
    
    Button(action: {
        
    },
           label: {
        Text("Hello")
            .padding()
            .frame(maxWidth: .infinity)
    })
    .buttonStyle(HighlightButtonStyle())
    .padding()
    
    Button(action: {
        
    },
           label: {
        Text("Hello")
            .padding()
            .frame(maxWidth: .infinity)
            .callToActionButton()
    })
    .buttonStyle(PressableButtonStyle())
    .padding()
}
