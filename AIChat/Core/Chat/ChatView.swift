//
//  ChatView.swift
//  AIChat
//
//  Created by ChenZhen on 25/4/25.
//

import SwiftUI

struct ChatView: View {

    @Environment(UserManager.self) private var userManager
    @Environment(AuthManager.self) private var authManager
    @Environment(AvatarManager.self) private var avatarManager
    @Environment(ChatManager.self) private var chatManager
    @Environment(AIManager.self) private var aiManager

    @State private var chatMessages: [ChatMessageModel] = []
    @State private var avatar: AvatarModel?
    @State private var currentUser: UserModel?
    @State private var chat: ChatModel?
    
    @State private var textFieldText: String = ""

    @State private var scrollPosition: String?
    @State private var showAlert: AnyAppAlert?
    @State private var showChatSettings: AnyAppAlert?
    @State private var showProfileModal: Bool = false
    @State private var isGeneratingResponse: Bool = false
    @State private var messageListener: ListenerRegistration?

    var avatarId: String = AvatarModel.mock.avatarId
    
    var body: some View {
        VStack(spacing: 8) {
            scrollViewSection
            textFieldSection
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    if isGeneratingResponse {
                        ProgressView()
                    }
                    Image(systemName: "ellipsis")
                        .padding(8)
                        .anyButton {
                            onChatSettingsPressed()
                        }
                }
            }
        }
        .showCustomAlert(type: .confirmationDialog, alert: $showChatSettings)
        .showCustomAlert(alert: $showAlert)
        .showModal(showModal: $showProfileModal) {
            if let avatar {
                profileModal(avatar: avatar)
            }
        }
        .task {
            await loadAvatar()
        }
        .task {
            await loadChat()
            await listenForChatMessages()
        }
        .onAppear {
            loadCurrentUser()
        }
        .onDisappear {
            messageListener?.remove()
        }
    }

    private func loadCurrentUser() {
        currentUser = userManager.currentUser
    }

    private func loadAvatar() async {
        do {
            let avatar = try await avatarManager.getAvatar(id: avatarId)
            self.avatar = avatar
            try? await avatarManager.addRecentAvatar(avatar: avatar)
        } catch {
            print("Error loading avatar: \(error)")
        }
    }

    private func loadChat() async {
        do {
            let uid = try authManager.getAuthId()
            chat = try await chatManager.getChat(userId: uid, avatarId: avatarId)
            print("Success loading chat.")
        } catch {
            print("Error loading chat.")
        }
    }

    private func getChatId() throws -> String {
        guard let chat else {
            throw ChatViewError.noChat
        }
        return chat.id
    }

    private func listenForChatMessages() async {
        do {
            let chatId = try getChatId()
            for try await value in chatManager.streamChatMessages(chatId: chatId, onListenerConfigured: { listener in
                messageListener?.remove()
                messageListener = listener
            }) {
                chatMessages = value.sorted(by: { $0.dateCreatedCalculated < $1.dateCreatedCalculated })
                scrollPosition = chatMessages.last?.id
            }
        } catch {
            print("Error attaching chat listener: \(error)")
        }
    }

    private var scrollViewSection: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(chatMessages) { message in
                    let isCurrentUser = message.authorId == authManager.auth?.uid
                    ChatBubbleViewBuilder(
                        message: message,
                        isCurrentUser: isCurrentUser,
                        currentUserProfileolor: currentUser?.profileColorCalculated ?? .accent,
                        imageName: isCurrentUser ? nil : avatar?.profileImageName,
                        onImagePressed: onAvatarImagePressed
                    )
                    .id(message.id)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .rotationEffect(.degrees(180))
        }
        .rotationEffect(.degrees(180))
        .scrollPosition(id: $scrollPosition, anchor: .center)
        .animation(.default, value: chatMessages.count)
        .animation(.default, value: scrollPosition)

    }

    private var textFieldSection: some View {
        TextField("Say something...", text: $textFieldText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .padding(12)
            .padding(.trailing, 60)
            .overlay(
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .padding(.trailing, 4)
                    .foregroundStyle(.accent)
                    .anyButton {
                        onSendMessagePressed()
                    }
                ,
                alignment: .trailing
            )
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(uiColor: .systemBackground))
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(uiColor: .secondarySystemBackground))
    }

    private func profileModal(avatar: AvatarModel) -> some View {
        ProfileModalView(
            imageName: avatar.profileImageName,
            title: avatar.name,
            subtitle: avatar.characterOption?.rawValue.capitalized,
            headline: avatar.characterDescription) {
                showProfileModal = false
            }
            .padding(40)
            .transition(.slide)
    }

    private func onSendMessagePressed() {

        let content = textFieldText

        Task {
            do {
                // Get userId
                let uid = try authManager.getAuthId()

                // Validate textfield text
                try TextValidationHelper.checkIfTextIsValid(text: content)

                // If chat is nil, then  create a new chat
                if chat == nil {
                    chat = try await createNewChat(uid: uid)
                }

                guard let chat else {
                    throw ChatViewError.noChat
                }

                // Create a user chat
                let newChatMessage = AIChatModel(role: .user, message: content)
                let message = ChatMessageModel.newUserMessage(chatId: chat.id, userId: uid, message: newChatMessage)

                // Upload user chat
                try await chatManager.addChatMessage(chatId: chat.id, message: message)
                textFieldText = ""

                // Generate AI response
                isGeneratingResponse = true
                var aiChats = chatMessages.compactMap({ $0.content })
                if let avatarDescription = avatar?.characterDescription, let name = avatar?.name {
                    let systemMessage = AIChatModel(
                        role: .system,
                        message: "You are a \(avatarDescription) with the intelligence of an AI. And your name is \(name) We are having a very casual conversation. You are my friend."
                    )
                    aiChats.insert(systemMessage, at: 0)
                }

                let response = try await aiManager.generateText(chats: aiChats)

                // Create AI chat
                let newAIMessage = ChatMessageModel.newAIMessage(chatId: chat.id, avatarId: avatarId, message: response)
                try await chatManager.addChatMessage(chatId: chat.id, message: newAIMessage)
            } catch let error {
                showAlert = AnyAppAlert(error: error)
            }
            isGeneratingResponse = false
        }
    }

    enum ChatViewError: Error {
        case noChat
    }

    private func createNewChat(uid: String) async throws -> ChatModel {
        let newChat = ChatModel.new(userId: uid, avatarId: avatarId)
        try await chatManager.createNewChat(chat: newChat)

        defer {
            Task {
                await listenForChatMessages()
            }
        }

        return newChat
    }

    private func onChatSettingsPressed() {
        showChatSettings = AnyAppAlert(
            title: "",
            subtitle: "What would you like to do?",
            buttons: {
                AnyView(
                    Group {
                        Button("Report User / Chat", role: .destructive) {

                        }
                        Button("Delete Chat", role: .destructive) {

                        }
                    }
                )
            }
        )
    }

    private func onAvatarImagePressed() {
        showProfileModal = true
    }
}

#Preview("Working chat") {
    NavigationStack {
        ChatView()
            .previewEnvironment()
    }
}

#Preview("Slow AI generation") {
    NavigationStack {
        ChatView()
            .environment(AIManager(service: MockAIService(delay: 10)))
            .previewEnvironment()
    }
}

#Preview("Failed AI generation") {
    NavigationStack {
        ChatView()
            .environment(AIManager(service: MockAIService(delay: 2.0, showError: true)))
            .previewEnvironment()
    }
}
