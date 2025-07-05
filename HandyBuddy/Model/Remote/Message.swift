//
//  Message.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 15/06/25.
//

import Foundation

struct Message: Codable {
    let id: String
    let sender: String
    let timestamp: String
    let content: String
}
