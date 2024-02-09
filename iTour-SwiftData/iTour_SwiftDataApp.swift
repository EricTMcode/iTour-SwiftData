//
//  iTour_SwiftDataApp.swift
//  iTour-SwiftData
//
//  Created by Eric on 09/02/2024.
//

import SwiftUI
import SwiftData

@main
struct iTour_SwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
