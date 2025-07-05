//
//  HandyBuddyApp.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 16/03/25.
//

import SwiftUI
import Firebase

@main
struct HandyBuddyApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(for: [
                    MessageSessionLocal.self,
                    MessageLocal.self,
                    ChatPreviewLocal.self,
                    TechnicianLocal.self
                ])
        }
    }
}


