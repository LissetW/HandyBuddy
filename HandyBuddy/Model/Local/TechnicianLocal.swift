//
//  Technician.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 04/07/25.
//


import SwiftData

@Model
class TechnicianLocal {
    @Attribute(.unique) var id: String
    var name: String?
    var lastName: String?
    var image: String?

    init(id: String, name: String?, lastName: String?, image: String?) {
        self.id = id
        self.name = name
        self.lastName = lastName
        self.image = image
    }
}
