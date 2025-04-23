//
//  AppView.swift
//  AIChat
//
//  Created by ChenZhen on 22/4/25.
//

import SwiftUI

struct AppView: View {

    @State var appState: AppState = AppState()

    var body: some View {
        AppViewBuilder(showTabBar: appState.showTabBar, tabbarView: {
            TabBarView()
        }, onboardingView: {
            WelcomeView()
        })
        .environment(appState)
    }
}

#Preview("AppView - Tabbar") {
    AppView(appState: AppState(showTabBar: true))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
}
