//
//  SignInWithGoogleButtonView.swift
//  AIChat
//
//  Created by ChenZhen on 9/5/25.
//

import SwiftUI
import GoogleSignInSwift

struct SignInWithGoogleButtonView: View {

    var body: some View {
        ZStack {
            Color(hex: "#F2F2F2")
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))

            HStack(spacing: 0) {
                Image("signInGoogle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44, height: 44)
                    .padding(.trailing, 0)

                Text("Sign in with Google")
                    .font(.title2)
                    .foregroundStyle(Color(hex: "#1F1F1F"))
                    .fontWeight(.medium)
                    .padding(.trailing, 16)
            }
        }
        .frame(height: 55)
        .disabled(true)

    }
}

#Preview {
    SignInWithGoogleButtonView()
        .padding(.horizontal, 20)
}
