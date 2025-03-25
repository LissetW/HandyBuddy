//
//  ContentView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 16/03/25.
//

import SwiftUI

struct ContentView: View {
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

struct SearchView: View {
    var body: some View {
        Text("Pantalla de Búsqueda")
    }
}
struct SavedView: View {
    var body: some View {
        Text("Pantalla de Saved")
    }
}
struct ChatView: View {
    var body: some View {
        Text("Pantalla de Chat")
    }
}
struct ProfileView: View {
    var body: some View {
        Text("Pantalla de Profile")
    }
}


#Preview {
    ContentView()
}

