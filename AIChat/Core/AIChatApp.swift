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
                .environment(delegate.dependencies.chatManager)
                .environment(delegate.dependencies.aiManager)
                .environment(delegate.dependencies.avatarManager)
                .environment(delegate.dependencies.userManager)
                .environment(delegate.dependencies.authManager)
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
    var dependencies: Dependencies!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        #if MOCK
        dependencies = Dependencies(config: .mock(isSignedIn: true))
        #elseif DEV
        dependencies = Dependencies(config: .dev)
        #else
        dependencies = Dependencies(config: .prod)
        #endif

        return true
    }
}

// Mock - mock dependencies
// Development - production dependencies + some extra dev tools
// Production - production dependencies
enum BuildConfiguration {
    case mock(isSignedIn: Bool), dev, prod
}

@MainActor
struct Dependencies {
    let authManager: AuthManager
    let userManager: UserManager
    let aiManager: AIManager
    let avatarManager: AvatarManager
    let chatManager: ChatManager

    init(config: BuildConfiguration) {

        switch config {
        case .mock(isSignedIn: let isSignedIn):
            authManager = AuthManager(service: MockAuthService(user: isSignedIn ? .mock() : nil))
            userManager = UserManager(services: MockUserServices(user: isSignedIn ? .mock : nil))
            aiManager = AIManager(service: MockAIService())
            avatarManager = AvatarManager(remote: MockAvatarService(), local: MockLocalAvatarPersistence())
            chatManager = ChatManager(service: MockChatService())
        case .dev:
            authManager = AuthManager(service: FirebaseAuthService())
            userManager = UserManager(services: ProductionUserServices())
            aiManager = AIManager(service: OpenAIService())
            avatarManager = AvatarManager(remote: FirebaseAvatarService(), local: SwiftDataLocalAvatarPersistence())
            chatManager = ChatManager(service: FirebaseChatService())
        case .prod:
            authManager = AuthManager(service: FirebaseAuthService())
            userManager = UserManager(services: ProductionUserServices())
            aiManager = AIManager(service: OpenAIService())
            avatarManager = AvatarManager(remote: FirebaseAvatarService(), local: SwiftDataLocalAvatarPersistence())
            chatManager = ChatManager(service: FirebaseChatService())
            print("PRODUCTION")
        }
    }
}

extension View {
    func previewEnvironment(isSignedIn: Bool = true) -> some View {
        self
            .environment(ChatManager(service: MockChatService()))
            .environment(AIManager(service: MockAIService()))
            .environment(AvatarManager(remote: MockAvatarService()))
            .environment(UserManager(services: MockUserServices(user: isSignedIn ? .mock : nil)))
            .environment(AuthManager(service: MockAuthService(user: isSignedIn ? .mock() : nil)))
            .environment(AppState())
    }
}
