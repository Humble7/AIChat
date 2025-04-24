//
//  UserModel.swift
//  AIChat
//
//  Created by ChenZhen on 24/4/25.
//

import Foundation
import SwiftUI

struct UserModel {
    let userId: String
    let dateCreated: Date?
    let didCompletedOnboarding: Bool?
    let profileColorHex: String?

    init(userId: String, dateCreated: Date? = nil, didCompletedOnboarding: Bool? = nil, profileColorHex: String? = nil) {
        self.userId = userId
        self.dateCreated = dateCreated
        self.didCompletedOnboarding = didCompletedOnboarding
        self.profileColorHex = profileColorHex
    }

    var profileColorCalculated: Color {
        guard let profileColorHex else {
            return .accent
        }

        return Color(hex: profileColorHex)
    }

    static var mock: Self {
        mocks[0]
    }

    static var mocks: [Self] {
        return [
            UserModel(
                userId: "user001",
                dateCreated: Date.now.addingTimeInterval(days: -30),
                didCompletedOnboarding: true,
                profileColorHex: "#FF6B6B"
            ),
            UserModel(
                userId: "user002",
                dateCreated: Date.now.addingTimeInterval(days: -15),
                didCompletedOnboarding: true,
                profileColorHex: "#4ECDC4"
            ),
            UserModel(
                userId: "user003",
                dateCreated: Date.now.addingTimeInterval(days: -7),
                didCompletedOnboarding: false,
                profileColorHex: "#FFD93D"
            ),
            UserModel(
                userId: "user004",
                dateCreated: Date.now,
                didCompletedOnboarding: false,
                profileColorHex: "#1A535C"
            )
        ]
    }
}
