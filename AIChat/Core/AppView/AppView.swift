//
//  AppView.swift
//  AIChat
//
//  Created by ChenZhen on 22/4/25.
//

import SwiftUI

struct AppView: View {
    @AppStorage("showTabbarView") var showTabBar: Bool = false
    var body: some View {
        AppViewBuilder(showTabBar: showTabBar, tabbarView: {
            TabBarView()
        }, onboardingView: {
            WelcomeView()
        })
    }
}

#Preview("AppView - Tabbar") {
    UserDefaults.standard.set(true, forKey: "showTabbarView")
    return AppView()
}

#Preview("AppView - Onboarding") {
    UserDefaults.standard.set(false, forKey: "showTabbarView")
    return AppView()
}
