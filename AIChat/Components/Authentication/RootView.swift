//
//  RootView.swift
//  AIChat
//
//  Created by ChenZhen on 8/5/25.
//

import SwiftUI

struct RootView: View {

    @State private var showSignInView = false

    var body: some View {
        ZStack {
            NavigationStack {
                AuthSettingsView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
