//
//  Message.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 3/10/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct Message {
    let text: String
    let toId: String
    let fromId: String
    var timestamp: Timestamp!
    var user: User?
    var currentUser: Bool

    init(data: [String: Any]) {
        self.text = data["text"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.fromId = data["fromId"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.currentUser = fromId == Auth.auth().currentUser?.uid
    }
}
