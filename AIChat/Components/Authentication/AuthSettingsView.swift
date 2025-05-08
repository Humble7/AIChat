//
//  AuthSettingsView.swift
//  AIChat
//
//  Created by ChenZhen on 8/5/25.
//

import SwiftUI

@MainActor
final class AuthSettingsViewModel {
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }

    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.badURL)
        }

        try await AuthenticationManager.shared.resetPassword(email: email)
    }

    func updatePassword() async throws {
        let password = "user123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }

    func updateEmail() async throws {
        let email = "user@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
}

struct AuthSettingsView: View {

    @State private var viewModel = AuthSettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        List {
            Button("Logout") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                         print(error)
                    }
                }
            }

            Section {
                Button("Reset Password") {
                    Task {
                        do {
                            try await viewModel.resetPassword()
                            print("password reset")
                        } catch {
                             print(error)
                        }
                    }
                }

                Button("Update Password") {
                    Task {
                        do {
                            try await viewModel.updatePassword()
                            print("password udpated")
                        } catch {
                             print(error)
                        }
                    }
                }

                Button("Update Email") {
                    Task {
                        do {
                            try await viewModel.updateEmail()
                            print("email  udpated")
                        } catch {
                             print(error)
                        }
                    }
                }
            } header: {
                Text("Email functions ")
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        AuthSettingsView(showSignInView: .constant(false))
    }
}
