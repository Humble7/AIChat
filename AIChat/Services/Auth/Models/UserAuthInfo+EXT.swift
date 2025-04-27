//
//  UserAuthInfo+EXT.swift
//  AIChat
//
//  Created by ChenZhen on 27/4/25.
//

import FirebaseAuth

extension UserAuthInfo {
    init (user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
