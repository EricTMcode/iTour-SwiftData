//
//  iTour_SwiftDataApp.swift
//  iTour-SwiftData
//
//  Created by Eric on 09/02/2024.
//

import SwiftData
import SwiftUI

@main
struct iTour_SwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Destinations", systemImage: "map")
                    }
                
                SightsView()
                    .tabItem {
                        Label("Sights", systemImage: "mappin.and.ellipse")
                    }
                
            }
        }
        .modelContainer(for: Destination.self)
    }
}
