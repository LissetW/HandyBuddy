//
//  SessionManager.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 03/07/25.
//


import SwiftUI
import FirebaseAuth

class SessionManager: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn = false

    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }
}