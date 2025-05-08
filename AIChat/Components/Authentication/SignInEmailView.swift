//
//  SignInEmailView.swift
//  AIChat
//
//  Created by ChenZhen on 8/5/25.
//

import SwiftUI

@MainActor
@Observable
final class SignInEmailViewModel {
    var email = ""
    var password = ""

    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found!")
            return
        }

         try await AuthenticationManager.shared.createUser(email: email, password: password)
    }

    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found!")
            return
        }

        try await AuthenticationManager.shared.signInUser(email: email, password: password)    }
}

struct SignInEmailView: View {

    @State private var viewModel = SignInEmailViewModel()

    @Binding var showSignInView: Bool

    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignInView  = false
                        return
                    } catch {
                        print(error)
                    }

                    do {
                        try await viewModel.signIn()
                        showSignInView  = false
                        return
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign in with email.")
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }

            Spacer()

        }
        .padding()
        .navigationTitle("Sign in with email")
    }
}

#Preview {
    NavigationStack {
        SignInEmailView(showSignInView: .constant(false))
    }
}
