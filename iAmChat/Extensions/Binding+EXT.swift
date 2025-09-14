//
//  Binding+EXT.swift
//  iAmChat
//
//  Created by Aleksandr Khristichenko on 14.09.2025.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init(get: {
            value.wrappedValue != nil
        },
                  set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        })
    }
}
