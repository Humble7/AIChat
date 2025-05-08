//
//  AuthenticationView.swift
//  AIChat
//
//  Created by ChenZhen on 8/5/25.
//

import SwiftUI

struct AuthenticationView: View {
    @Binding var showSignInView: Bool

    var body: some View {
        NavigationLink {
            SignInEmailView(showSignInView: $showSignInView)
        } label: {
            Text("Sign in with email.")
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

        }
        .padding()
        .navigationTitle("Sign in")
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(false))
    }
}
