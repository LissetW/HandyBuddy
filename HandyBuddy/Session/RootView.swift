//
//  RootView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 04/07/25.
//


import SwiftUI

struct RootView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            MainView()
        } else {
            LoginView()
        }
    }
}
