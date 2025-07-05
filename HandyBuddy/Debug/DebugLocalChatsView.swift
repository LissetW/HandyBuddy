//
//  DebugLocalChatsView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 04/07/25.
//


import SwiftData

func debugPrintLocalChats(context: ModelContext) {
    do {
        let chats = try context.fetch(FetchDescriptor<ChatPreviewLocal>())
        print("[Debug] Number of local chats: \(chats.count)")
        
        for chat in chats {
            print("Name: \(chat.name) \(chat.lastName)")
            print("Last message: \(chat.lastMessage)")
            print("Date: \(chat.lastMessageDate)")
            
            if let session = chat.fullMessageSession {
                print("Session ID: \(session.sessionId) - Messages: \(session.messages.count)")
                for message in session.messages {
                    print("  [\(message.sender)] \(message.content) @ \(message.timestamp)")
                }
            } else {
                print("Warning: No associated message session found.")
            }
            print("--------------------------------------")
        }
    } catch {
        print("Error while fetching local chats: \(error)")
    }
}
