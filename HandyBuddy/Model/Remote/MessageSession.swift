//
//  MessageSession.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 15/06/25.
//

import Foundation

struct MessageSession: Codable {
    let sessionId: String
    let messages: [Message]
}
