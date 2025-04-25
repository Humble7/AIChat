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
    @State private var popularAvatars = AvatarModel.mocks

    var body: some View {
        NavigationStack {
            List {
                featuredSection
                categorySection
                popularSection
            }
            .navigationTitle("Explore")
        }
    }

    private var featuredSection: some View {
        Section {
            CarouseView(items: featuredAvatars) { avatar in
                HeroCellView(title: avatar.name, subtitle: avatar.characterDescription, imageName: avatar.profileImageName)
                    .anyButton {

                    }
            }
            .avoidGlitchBugInList()
            .removeListRowFormatting()
        } header: {
            Text("Featured")
        }
    }

    private var categorySection: some View {
        Section {
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(categories, id: \.self) { category in
                        CategoryCellView(title: category.plural.capitalized, imageName: Constants.randomImage)
                            .anyButton {

                            }
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

    private var popularSection: some View {
        Section {
            ForEach(popularAvatars, id: \.self) { avatar in
                CustomListCellView(imageName: avatar.profileImageName, title: avatar.name, subtitle: avatar.characterDescription)
                    .anyButton(.highlight) {

                    }
                    .removeListRowFormatting()
            }
        } header: {
            Text("Popular")
        }
    }
}

#Preview {
    ExploreView()
}
