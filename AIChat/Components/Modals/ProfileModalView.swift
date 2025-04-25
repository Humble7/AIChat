//
//  ProfileModalView.swift
//  AIChat
//
//  Created by ChenZhen on 25/4/25.
//

import SwiftUI

struct ProfileModalView: View {

    var imageName: String? = Constants.randomImage
    var title: String? = "Alpha"
    var subtitle: String? = "Alien"
    var headline: String? = "An alien in the park."
    var onXMarkPressed: () -> Void = {}

    var body: some View {
        VStack(spacing: 0) {
            if let imageName {
                ImageLoaderView(urlString: imageName, forceTransitionAnimation: true)
                    .aspectRatio(1, contentMode: .fit)
            }

            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                if let headline {
                    Text(headline)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            Image(systemName: "xmark.circle.fill")
            .font(.title)
            .foregroundStyle(.black)
            .padding(4)
            .tappableBackground()
            .anyButton {
                onXMarkPressed()
            }
            .padding(8),
            alignment: .topTrailing
        )
    }
}

#Preview("Modal with Image") {
    ZStack {
        Color.gray.ignoresSafeArea()

        ProfileModalView()
            .padding(40)
    }
}

#Preview("Modal without Image") {
    ZStack {
        Color.gray.ignoresSafeArea()

        ProfileModalView(imageName: nil)
            .padding(40)
    }
}
