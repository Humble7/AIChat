//
//  NavigationPathOption.swift
//  AIChat
//
//  Created by ChenZhen on 26/4/25.
//
import SwiftUI

enum NavigationPathOption: Hashable {
    case chat(avatarId: String, chat: ChatModel?)
    case category(category: CharacterOption, imageName: String)
}

extension View {
    func navigationDestinationForCoreModule(path: Binding<[NavigationPathOption]>) -> some View {
        self
            .navigationDestination(for: NavigationPathOption.self) { newValue in
                switch newValue {
                case .chat(avatarId: let avatarId, chat: let chat):
                    ChatView(avatarId: avatarId, chat: chat)
                case .category(category: let category, imageName: let imageName):
                    CategoryListView(path: path, category: category, imageName: imageName)
                }
            }
    }
}
