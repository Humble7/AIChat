//
//  Dictionary+EXT.swift
//  AIChat
//
//  Created by ChenZhen on 12/5/25.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    func asAlphabeticalArray() -> [(key: String, value: Any)] {
        self.map { (key: $0, value: $1) }
    }
}
