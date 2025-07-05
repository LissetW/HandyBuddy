//
//  SearchView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 24/03/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField(NSLocalizedString("search.placeholder", comment: ""), text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TechnicianListView(searchText: searchText)
            }
            .navigationTitle(NSLocalizedString("search.title", comment: ""))
        }
    }
}


