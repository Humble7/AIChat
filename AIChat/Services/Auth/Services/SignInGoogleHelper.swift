//
//  SignInGoogleHelper.swift
//  AIChat
//
//  Created by ChenZhen on 9/5/25.
//

import Foundation
@preconcurrency import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignResultModel {
    let idToken: String
    let accessToken: String
}

@MainActor
final class SignInGoogleHelper {

    func signIn() async throws -> GoogleSignResultModel {

        guard let topVC = ApplicationUtilities.shared.topViewController else {
            throw GoogleSignInError.noViewController
        }

        // Start the sign in flow!
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)

        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw GoogleSignInError.badResponse
        }

        let accessToken = gidSignInResult.user.accessToken.tokenString
        let tokens = GoogleSignResultModel(idToken: idToken, accessToken: accessToken)

        return tokens
    }

    private enum GoogleSignInError: LocalizedError {
        case noViewController
        case badResponse

        var errorDescription: String? {
            switch self {
            case .noViewController:
                return "Could not find top view controller."
            case .badResponse:
                return "Google Sign In had a bad response."
            }
        }
    }
}
