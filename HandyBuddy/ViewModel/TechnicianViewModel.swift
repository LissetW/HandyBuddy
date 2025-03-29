//
//  TechnicianViewModel.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 29/03/25.
//

import SwiftUI

class TechnicianViewModel: ObservableObject {
    @Published var technicians: [Technician] = [
        Technician(
            id: UUID(),
            name: "Ana López",
            picture: "person.fill",
            speciality: ["Carpenter"],
            rating: 4.5,
            reviews: ["Great job", "Highly recommended"],
            servicesCount: 95
        ),
        Technician(
            id: UUID(),
            name: "Carlos Díaz",
            picture: "person.fill",
            speciality: ["Painter", "Plumber"],
            rating: 4.7,
            reviews: ["Fast and efficient", "Good prices"],
            servicesCount: 150
        ),
        Technician.example
    ]
}

