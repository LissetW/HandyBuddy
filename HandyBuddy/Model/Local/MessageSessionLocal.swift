//
//  MessageSessionLocal.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 03/07/25.
//

import SwiftData

@Model
class MessageSessionLocal: Identifiable {
    @Attribute(.unique) var sessionId: String

    @Relationship(deleteRule: .cascade)
    var messages: [MessageLocal] = []

    var id: String { sessionId }

    init(sessionId: String) {
        self.sessionId = sessionId
    }
}
