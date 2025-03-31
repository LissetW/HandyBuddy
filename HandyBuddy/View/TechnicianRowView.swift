//
//  TechnicianRowView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 29/03/25.
//

import SwiftUI

struct TechnicianRowView: View {
    @ObservedObject var viewModel: TechnicianViewModel
    let technician: Technician

    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .center, spacing: 5) {
                Image(systemName: technician.picture)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                Text(technician.name)
                    .font(.headline)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Spacer()
                    RatingView(rating: technician.rating)
                    Text("\(technician.rating, specifier: "%.1f")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Text(technician.speciality.joined(separator: ", "))

                if let currentReview = viewModel.currentReviews[technician.id] {
                    Text("🗣️ \(currentReview)")
                        .font(.footnote)
                        .italic()
                        .foregroundColor(.blue)
                        .lineLimit(1)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TechnicianRowView(viewModel: TechnicianViewModel(), technician: Technician.example)
}
