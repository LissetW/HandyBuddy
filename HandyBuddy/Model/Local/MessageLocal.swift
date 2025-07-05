//
//  MessageLocal.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 03/07/25.
//

import SwiftData

@Model
class MessageLocal: Identifiable {
    @Attribute(.unique) var id: String
    var sender: String
    var timestamp: String
    var content: String

    @Relationship
    var session: MessageSessionLocal?

    var idProperty: String { id }

    init(id: String, sender: String, timestamp: String, content: String) {
        self.id = id
        self.sender = sender
        self.timestamp = timestamp
        self.content = content
    }
}
