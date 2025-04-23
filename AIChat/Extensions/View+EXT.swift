//
//  View+EXT.swift
//  AIChat
//
//  Created by ChenZhen on 23/4/25.
//

import SwiftUI

extension View {
    func callToActionButton() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
    }
}
