//
//  CreateAvatarView.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 09.09.2025.
//

import SwiftUI

struct CreateAvatarView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var avatarName: String = ""
    @State private var characterOption: CharacterOption = .default
    @State private var characterAction: CharacterAction = .default
    @State private var characterLocation: CharacterLocation = .default
    @State private var isGenerating: Bool = false
    @State private var generatedImage: UIImage?
    @State private var isSaving: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                nameSection
                attributesSection
                imageSection
                saveSection
            }
            .navigationTitle("Create Avatar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            }
        }
    }
    
    private func onBackButtonPressed() {
        dismiss()
    }
    
    private var backButton: some View {
        Image(systemName: "xmark")
            .font(.title2)
            .fontWeight(.semibold)
            .anyButton(option: .plain) {
                onBackButtonPressed()
            }
    }
    
    private var nameSection: some View {
        Section(content: {
            TextField("Player 1", text: $avatarName)
        },
                header: {
            Text("Name your avatar*")
        })
    }
    
    private var attributesSection: some View {
        Section(content: {
            Picker(selection: $characterOption,
                   content: {
                ForEach(CharacterOption.allCases, id: \.self) { option in
                    Text(option.rawValue.capitalized)
                        .tag(option)
                }
            },
                   label: {
                Text("is a...")
            })
            
            Picker(selection: $characterAction,
                   content: {
                ForEach(CharacterAction.allCases, id: \.self) { action in
                    Text(action.rawValue.capitalized)
                        .tag(action)
                }
            },
                   label: {
                Text("that is...")
            })
            
            Picker(selection: $characterLocation,
                   content: {
                ForEach(CharacterLocation.allCases, id: \.self) { location in
                    Text(location.rawValue.capitalized)
                        .tag(location)
                }
            },
                   label: {
                Text("in the...")
            })
        },
                header: {
            Text("Attributes")
        })
    }
    
    private var imageSection: some View {
        Section {
            HStack(alignment: .top, spacing: 8) {
                ZStack {
                    Text("Generate Image")
                        .underline()
                        .foregroundStyle(.accent)
                        .anyButton(option: .plain) {
                            onGenerateImagePressed()
                        }
                        .opacity(isGenerating ? 0 : 1)
                    ProgressView()
                        .tint(.accent)
                        .opacity(isGenerating ? 1 : 0)
                }
                .disabled(isGenerating || avatarName.isEmpty)
                Circle()
                    .fill(Color.secondary.opacity(0.3))
                    .overlay {
                        ZStack {
                            if let generatedImage {
                                Image(uiImage: generatedImage)
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                    }
                    .clipShape(.circle)
            }
            .removeListRowFormatting()
        }
    }
    
    private var saveSection: some View {
        Section {
            AsyncCallToActionButton(isLoading: isSaving,
                                    buttonTitle: "Save",
                                    action: onSavePressed)
            .removeListRowFormatting()
            .padding(.top, 24)
            .opacity(generatedImage == nil ? 0.5 : 1)
            .disabled(generatedImage == nil)
        }
    }
    
    private func onGenerateImagePressed() {
        isGenerating = true
        Task {
            try? await Task.sleep(for: .seconds(2))
            generatedImage = UIImage(systemName: "star.fill")
            isGenerating = false
        }
    }
    
    private func onSavePressed() {
        isSaving = true
        Task {
            try? await Task.sleep(for: .seconds(2))
            dismiss()
            isSaving = false
        }
    }
}

#Preview {
    CreateAvatarView()
}
