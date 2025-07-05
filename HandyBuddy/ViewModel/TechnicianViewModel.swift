//
//  TechnicianViewModel.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 29/03/25.
//

import SwiftUI

@MainActor
class TechnicianViewModel: ObservableObject {
    @Published var technicians: [Technician] = []

    func fetchTechnicians() async {
        guard let url = URL(string: "https://handy-buddy.free.beeceptor.com/technician/all") else {
            print("URL inválida")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedTechnicians = try JSONDecoder().decode([Technician].self, from: data)
            self.technicians = decodedTechnicians
        } catch {
            print("rror al obtener técnicos: \(error.localizedDescription)")
        }
    }
}
