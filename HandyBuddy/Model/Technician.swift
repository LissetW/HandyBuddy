//
//  Technician.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 29/03/25.
//

import SwiftUI

struct Technician: Identifiable {
    let id: UUID
    let name: String
    let picture: String
    let speciality: [String]
    let rating: Double
    let reviews: [String]
    let servicesCount: Int

    // Example data
    static let example = Technician(
        id: UUID(),
        name: "Juan Pérez",
        picture: "person.fill",
        speciality: ["Electrician", "Plumber"],
        rating: 4.8,
        reviews: ["Excellent service", "Very professional"],
        servicesCount: 120
    )
}

