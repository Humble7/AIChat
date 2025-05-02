//
//  Collection+EXT.swift
//  AIChat
//
//  Created by ChenZhen on 2/5/25.
//

import Foundation

extension Collection {
    func first(upTo value: Int) -> [Element] {
        guard !isEmpty else { return [] }
        let max = Swift.min(count, value)
        return Array(prefix(max))
    }

    func last(upTo value: Int) -> [Element]? {
        guard !isEmpty else { return nil }
        let max = Swift.min(count, value)
        return Array(suffix(max))
    }
}
