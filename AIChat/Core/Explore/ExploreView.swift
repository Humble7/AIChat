//
//  ExploreView.swift
//  AIChat
//
//  Created by ChenZhen on 23/4/25.
//

import SwiftUI

struct ExploreView: View {

    @State private var featuredAvatars = AvatarModel.mocks
    @State private var categories: [CharacterOption] = CharacterOption.allCases

    var body: some View {
        NavigationStack {
            List {
                featuredSection
                categorySection
            }
            .navigationTitle("Explore")
        }
    }

    private var featuredSection: some View {
        Section {
            CarouseView(items: featuredAvatars) { avatar in
                HeroCellView(title: avatar.name, subtitle: avatar.characterDescription, imageName: avatar.profileImageName)
            }
            .avoidGlitchBugInList()
            .removeListRowFormatting()
        } header: {
            Text("Featured Avatars")
        }
    }

    private var categorySection: some View {
        Section {
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(categories, id: \.self) { category in
                        CategoryCellView(title: category.rawValue.capitalized, imageName: Constants.randomImage)
                    }
                }
            }
            .frame(height: 140)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            .avoidGlitchBugInList()
            .removeListRowFormatting()
        } header: {
            Text("Categories")
        }
    }
}

#Preview {
    ExploreView()
}
