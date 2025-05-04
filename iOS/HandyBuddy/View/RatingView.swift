//
//  RatingView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 29/03/25.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    let maxRating: Int = 5  // Usamos un valor constante para el rango

    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<maxRating, id: \.self) { index in
                if Double(index) < floor(rating) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                } else if Double(index) < ceil(rating) {
                    Image(systemName: "star.leadinghalf.filled")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            RatingView(rating: 3.0)
            RatingView(rating: 3.5)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


