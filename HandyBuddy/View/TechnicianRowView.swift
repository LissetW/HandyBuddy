//
//  TechnicianRowView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 29/03/25.
//

import SwiftUI

struct TechnicianRowView: View {
    let technician: Technician

    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .center, spacing: 5) {
                AsyncImage(url: URL(string: technician.image ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                
                Text("\(technician.name ?? "")")
                    .font(.headline)
            }

            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Spacer()
                }
                Text(technician.typeOfWork?.joined(separator: ", ") ?? NSLocalizedString("technicianRow.noSpecialty", comment: ""))
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
    }
}
