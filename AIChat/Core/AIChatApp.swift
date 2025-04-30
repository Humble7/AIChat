//
//  AIChatApp.swift
//  AIChat
//
//  Created by ChenZhen on 22/4/25.
//

import SwiftUI
import FirebaseCore

@main
struct AIChatApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(delegate.authManager)
                .environment(delegate.userManager)
        }
    }
}

struct EnvironmentBuilderView<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .environment(AuthManager(service: FirebaseAuthService()))
            .environment(UserManager(services: ProductionUserServices()))
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var authManager: AuthManager!
    var userManager: UserManager!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        authManager = AuthManager(service: FirebaseAuthService())
        userManager = UserManager(services: ProductionUserServices())

        return true
    }
}
