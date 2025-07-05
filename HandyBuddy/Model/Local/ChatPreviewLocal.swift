//
//  ChatPreviewLocal.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 03/07/25.
//

import SwiftData

@Model
class ChatPreviewLocal: Identifiable {
    @Attribute(.unique) var id: String
    var name: String
    var lastName: String
    var imageName: String
    var lastMessage: String
    var lastMessageDate: String

    @Relationship(deleteRule: .cascade)
    var fullMessageSession: MessageSessionLocal?

    var idProperty: String { id }

    init(
        id: String,
        name: String,
        lastName: String,
        imageName: String,
        lastMessage: String,
        lastMessageDate: String,
        fullMessageSession: MessageSessionLocal? = nil
    ) {
        self.id = id
        self.name = name
        self.lastName = lastName
        self.imageName = imageName
        self.lastMessage = lastMessage
        self.lastMessageDate = lastMessageDate
        self.fullMessageSession = fullMessageSession
    }

}
