//
//  TechnicianListView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 29/03/25.
//

import SwiftUI

struct TechnicianListView: View {
    @StateObject private var viewModel = TechnicianViewModel()
    var searchText: String

    var filteredTechnicians: [Technician] {
        if searchText.isEmpty {
            return viewModel.technicians
        } else {
            return viewModel.technicians.filter { technician in
                technician.name.localizedCaseInsensitiveContains(searchText) ||
                technician.speciality.joined(separator: ", ").localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredTechnicians) { technician in
                TechnicianRowView(viewModel: viewModel, technician: technician)
            }
        }
    }
}

#Preview {
    TechnicianListView(searchText: "")
}
