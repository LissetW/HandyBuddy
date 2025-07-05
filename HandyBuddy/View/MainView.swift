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
                    Text("main.tab.search")
                }

            ChatView()
                .tabItem {
                    Image(systemName: "message")
                    Text("main.tab.chat")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("main.tab.profile")
                }
        }
    }
}
