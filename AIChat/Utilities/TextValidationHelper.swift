//
//  TextValidationHelper.swift
//  AIChat
//
//  Created by ChenZhen on 25/4/25.
//

import Foundation

struct TextValidationHelper {
    enum TextValidationError: LocalizedError {
        case notEnoughCharacter(min: Int)
        case hasBadWords

        var errorDescription: String? {
            switch self {
            case .notEnoughCharacter(let min):
                return "Please add at least \(min) characters."
            case .hasBadWords:
                return "Bad word detected. Please rephrase your message"
            }
        }
    }

    static func checkIfTextIsValid(text: String) throws {
        let minimumCharacterCount = 3
        guard text.count >= minimumCharacterCount else {
            throw TextValidationError.notEnoughCharacter(min: minimumCharacterCount)
        }

        let badWords = ["shit", "bitch", "ass"]
        if badWords.contains(text.lowercased()) {
            throw TextValidationError.hasBadWords
        }
    }
}
