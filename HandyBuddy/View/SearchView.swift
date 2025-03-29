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
                TextField("Find technician...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TechnicianListView(searchText: searchText)
            }
            .navigationTitle("Find technician")
        }
    }
}

#Preview {
    SearchView()
}

