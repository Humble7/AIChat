//
//  AIService.swift
//  AIChat
//
//  Created by ChenZhen on 30/4/25.
//

import SwiftUI

protocol AIService: Sendable {
    func generateImage(input: String) async throws -> UIImage
}
