//
//  ChatPreview.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 15/06/25.
//

import Foundation

struct ChatPreview: Identifiable {
    let id: String
    let name: String
    let lastName: String
    let imageName: String
    let lastMessage: String
    let lastMessageDate: String
    let fullSession: MessageSession
}
