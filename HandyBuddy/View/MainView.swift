//
//  MainView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 16/03/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Find")
                }
            SavedView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Saved")
                }
            ChatView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Chat")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainView()
}

