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
    
    @Published var currentReviews: [UUID: String] = [:]
    private var reviewTimers: [UUID: Timer] = [:]
    
    init() {
        startReviewRotation()
    }
    
    private func startReviewRotation() {
        for technician in technicians {
            guard !technician.reviews.isEmpty else { continue }
            
            currentReviews[technician.id] = technician.reviews.first
            
            var reviewIndex = 0
            
            let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                reviewIndex = (reviewIndex + 1) % technician.reviews.count
                DispatchQueue.main.async {
                    self.currentReviews[technician.id] = technician.reviews[reviewIndex]
                }
            }
            reviewTimers[technician.id] = timer
        }
    }
    
    deinit {
        reviewTimers.values.forEach { $0.invalidate() }
    }
}
