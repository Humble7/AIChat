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
            ZStack {
                Color.red.ignoresSafeArea()
                Text("Tabbar")
            }
        }, onboardingView: {
            ZStack {
                Color.blue.ignoresSafeArea()
                Text("Onboarding")
            }
        })
        .onTapGesture {
            showTabBar.toggle()
        }
    }
}

#Preview("AppView - Tabbar") {
    AppView(showTabBar: true)
}

#Preview("AppView - Onboarding") {
    AppView(showTabBar: false)
}
