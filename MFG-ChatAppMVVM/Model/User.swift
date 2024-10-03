//
//  User.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 12/9/24.
//

import Foundation

struct User {
    let uuid: String
    let name: String
    let username: String
    let email: String
    let profileImageUrl: String
    init(data: [String: Any]) {
        self.uuid = data["uuid"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}
