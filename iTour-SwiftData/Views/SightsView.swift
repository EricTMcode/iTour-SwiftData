//
//  SightsView.swift
//  iTour-SwiftData
//
//  Created by Eric on 10/02/2024.
//

import SwiftData
import SwiftUI

struct SightsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Sight.name) var sights: [Sight]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach (sights) { sight in
                    NavigationLink(value: sight.destination) {
                        Text(sight.name)
                    }
                }
                .onDelete(perform: deleteSights)
            }
            .navigationTitle("Sights")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
        }
    }
    
    func deleteSights(_ indexSet: IndexSet) {
        for index in indexSet {
            let sight = sights[index]
            modelContext.delete(sight)
        }
    }
}

#Preview {
    SightsView()
}
