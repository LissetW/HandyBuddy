//
//  HandyBuddyApp.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 16/03/25.
//

import SwiftUI

@main
struct HandyBuddyApp: App {
    
    @AppStorage("isRegistered") private var isRegistered = false
    
    var body: some Scene {
        WindowGroup {
            if isRegistered {
                MainView()
            } else {
                RegisterView()
            }
        }
    }
}
