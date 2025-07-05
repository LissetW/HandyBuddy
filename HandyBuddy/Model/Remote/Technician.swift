//
//  Technician.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 29/03/25.
//

import Foundation

struct Technician: Codable, Identifiable {
    let id: String?
    let name: String?
    let lastName: String?
    let email: String?
    let image: String?
    let typeOfWork: [String]?
    let workDescription: String?
    let location: Location?
    let serviceRadiusKM: Int?
    let phoneNumber: String?
    let numberOfReviews: Int?
    let commentIds: [String]

    var uuid: UUID { UUID() }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case lastName = "last_name"
        case email
        case image
        case typeOfWork = "type_of_work"
        case workDescription = "work_description"
        case location
        case serviceRadiusKM = "service_radius_km"
        case phoneNumber = "phone_number"
        // case ratingAverage = "rating_average" Todo: calculate
        case numberOfReviews = "number_of_reviews"
        case commentIds = "comment_ids"
    }
}
