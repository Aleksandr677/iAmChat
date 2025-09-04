//
//  AvatarModel.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 04.09.2025.
//

import Foundation

struct AvatarModel {
    let avatarId: String
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    let profileImageName: String?
    let authorId: String?
    let dateCreated: Date?
    
    init(
        avatarId: String,
        name: String? = nil,
        characterOption: CharacterOption? = nil,
        characterAction: CharacterAction? = nil,
        characterLocation: CharacterLocation? = nil,
        profileImageName: String? = nil,
        authorId: String? = nil,
        dateCreated: Date? = nil
    ) {
        self.avatarId = avatarId
        self.name = name
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
        self.profileImageName = profileImageName
        self.authorId = authorId
        self.dateCreated = dateCreated
    }
    
    var characterDescription: String {
        AvatarDescriptionBuilder(avatarModel: self).characterDescription
    }
    
    static var mock: AvatarModel {
        mocks[0]
    }
    
    static var mocks: [AvatarModel] {
        [
            AvatarModel(
                avatarId: UUID().uuidString,
                name: "Alpha",
                characterOption: .alien,
                characterAction: .crying,
                characterLocation: .museum,
                profileImageName: Constants.randomImageURL,
                authorId: UUID().uuidString,
                dateCreated: .now
            ),
            AvatarModel(
                avatarId: UUID().uuidString,
                name: "Beta",
                characterOption: .cat,
                characterAction: .fighting,
                characterLocation: .city,
                profileImageName: Constants.randomImageURL,
                authorId: UUID().uuidString,
                dateCreated: .now
            ),
            AvatarModel(
                avatarId: UUID().uuidString,
                name: "Gamma",
                characterOption: .dog,
                characterAction: .sitting,
                characterLocation: .beach,
                profileImageName: Constants.randomImageURL,
                authorId: UUID().uuidString,
                dateCreated: .now
            ),
            AvatarModel(
                avatarId: UUID().uuidString,
                name: "Delta",
                characterOption: .man,
                characterAction: .sleeping,
                characterLocation: .park,
                profileImageName: Constants.randomImageURL,
                authorId: UUID().uuidString,
                dateCreated: .now
            )
        ]
    }
}

struct AvatarDescriptionBuilder {
    let characterOption: CharacterOption
    let characterAction: CharacterAction
    let characterLocation: CharacterLocation
    
    init(
        characterOption: CharacterOption,
        characterAction: CharacterAction,
        characterLocation: CharacterLocation
    ) {
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
    }
    
    
    init(avatarModel: AvatarModel) {
        self.init(characterOption: avatarModel.characterOption ?? .default,
                  characterAction: avatarModel.characterAction ?? .default,
                  characterLocation: avatarModel.characterLocation ?? .default)
    }
    
    var characterDescription: String {
        "A \(characterOption.rawValue) that is \(characterAction.rawValue) in the \(characterLocation.rawValue)"
    }
}

enum CharacterOption: String {
    case man, woman, alien, dog, cat
    
    static var `default`: Self {
        .man
    }
}

enum CharacterAction: String {
    case smiling, sitting, eating, drinking, walking, shopping, studying, working, relaxing, fighting, sleeping, crying
    
    static var `default`: Self {
        .sitting
    }
}

enum CharacterLocation: String {
    case park, mall, museum, city, desert, forest, beach, mountain, space
    
    static var `default`: Self {
        .park
    }
}
