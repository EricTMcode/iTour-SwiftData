//
//  Destination.swift
//  iTour-SwiftData
//
//  Created by Eric on 09/02/2024.
//

import Foundation
import SwiftData

@Model
class Destination {
    @Attribute(.unique)
    var name: String
    var details: String
    var date: Date
    var priority: Int
    @Relationship(deleteRule: .cascade, inverse: \Sight.destination) var sights = [Sight]()
    @Attribute(.externalStorage) var image: Data?
    
    init(name: String = "", details: String = "" , date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
