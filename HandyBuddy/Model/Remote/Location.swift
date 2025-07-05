//
//  Location.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 11/06/25.
//

import Foundation

struct Location: Codable {
    let country: String?
    let state: String?
    let city: String?
    let latitude: Double
    let longitude: Double
    let postalCode: String?

    enum CodingKeys: String, CodingKey {
        case country
        case state
        case city
        case latitude
        case longitude
        case postalCode = "postal_code"
    }
}
