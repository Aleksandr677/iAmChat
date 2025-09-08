//
//  UserModel.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 08.09.2025.
//

import Foundation
import SwiftUI

struct UserModel: Identifiable {
    let id: String
    let dateCreated: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?
    
    init(id: String, dateCreated: Date? = nil, didCompleteOnboarding: Bool? = nil, profileColorHex: String? = nil) {
        self.id = id
        self.dateCreated = dateCreated
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }
    
    var profileColorCalculated: Color {
        guard let profileColorHex else { return .accent }
        return Color(hex: profileColorHex)
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        return [
            UserModel(id: UUID().uuidString,
                      dateCreated: .now.addingTimeInterval(days: -4),
                      didCompleteOnboarding: false,
                      profileColorHex: "#7DFF33"),
            UserModel(id: UUID().uuidString,
                      dateCreated: .now.addingTimeInterval(days: -2),
                      didCompleteOnboarding: true,
                      profileColorHex: "#7DFF66"),
            UserModel(id: UUID().uuidString,
                      dateCreated: .now.addingTimeInterval(days: -1),
                      didCompleteOnboarding: false,
                      profileColorHex: "#7DFF11"),
            UserModel(id: UUID().uuidString,
                      dateCreated: .now.addingTimeInterval(days: -3, hours: -2),
                      didCompleteOnboarding: true,
                      profileColorHex: "#7DFF22")
        ]
    }
}

