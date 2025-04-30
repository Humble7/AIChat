//
//  OnboardingCompletedView.swift
//  AIChat
//
//  Created by ChenZhen on 23/4/25.
//

import SwiftUI

struct OnboardingCompletedView: View {

    @Environment(AppState.self) private var root
    @Environment(UserManager.self) private var userManager

    @State private var isCompletingProfileSetup: Bool = false
    var selectedColor: Color = .orange

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Setup complete!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(selectedColor)

            Text("We've set up your profile and you're ready to start to chatting")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, content: {
            AsyncCallToActionButton(
                isLoading: isCompletingProfileSetup,
                title: "Finish",
                action: onFinishButtonPressed
            )
        })
        .padding(16)
        .toolbar(.hidden, for: .navigationBar)
    }

    func onFinishButtonPressed() {
        isCompletingProfileSetup = true
        // other logic to complete onboarding.
        Task {
            let hex = selectedColor.asHex()
            try await userManager.markOnBoardingCompletedForCurrentUser(profileColorHex: hex)
            isCompletingProfileSetup = false
            root.updateViewState(showTabBarView: true)
        }
    }
}

#Preview {
    OnboardingCompletedView(selectedColor: .mint)
        .environment(UserManager(services: MockUserServices(user: nil)))
        .environment(AppState())
}
