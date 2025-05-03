//
//  UserModel.swift
//  AIChat
//
//  Created by ChenZhen on 24/4/25.
//

import Foundation
import SwiftUI

struct UserModel: Codable {
    let userId: String
    let email: String?
    let isAnonymous: Bool?
    let creationDate: Date?
    let creationVersion: String?
    let lastSignInDate: Date?

    let didCompletedOnboarding: Bool?
    let profileColorHex: String?

    init(
        userId: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        creationDate: Date? = nil,
        creationVersion: String? = nil,
        lastSignInDate: Date? = nil,
        didCompletedOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.creationVersion = creationVersion
        self.lastSignInDate = lastSignInDate
        self.didCompletedOnboarding = didCompletedOnboarding
        self.profileColorHex = profileColorHex
    }

    init(auth: UserAuthInfo, creationVersion: String?) {
        self.init(
            userId: auth.uid,
            email: auth.email,
            isAnonymous: auth.isAnonymous,
            creationDate: auth.creationDate,
            creationVersion: creationVersion,
            lastSignInDate: auth.lastSignInDate
         )
    }

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email
        case isAnonymous = "is_anonymous"
        case creationDate = "creation_date"
        case creationVersion = "creation_version" 
        case lastSignInDate = "last_sign_in_date"
        case didCompletedOnboarding = "did_completed_onboarding"
        case profileColorHex = "profile_color_hex"
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
                creationDate: Date.now.addingTimeInterval(days: -30),
                didCompletedOnboarding: true,
                profileColorHex: "#4ECDC4"
            ),
            UserModel(
                userId: "user002",
                creationDate: Date.now.addingTimeInterval(days: -15),
                didCompletedOnboarding: true,
                profileColorHex: "#FF6B6B"
            ),
            UserModel(
                userId: "user003",
                creationDate: Date.now.addingTimeInterval(days: -7),
                didCompletedOnboarding: false,
                profileColorHex: "#FFD93D"
            ),
            UserModel(
                userId: "user004",
                creationDate: Date.now,
                didCompletedOnboarding: false,
                profileColorHex: "#1A535C"
            )
        ]
    }
}
