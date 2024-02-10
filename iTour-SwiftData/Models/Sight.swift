//
//  Sight.swift
//  iTour-SwiftData
//
//  Created by Eric on 10/02/2024.
//

import Foundation
import SwiftData

@Model
class Sight {
    var name: String
    var destination: Destination?
    
    init(name: String) {
        self.name = name
    }
}
