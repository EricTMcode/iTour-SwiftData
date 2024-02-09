//
//  ContentView.swift
//  iTour-SwiftData
//
//  Created by Eric on 09/02/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var destinations: [Destination]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(destinations) { destination in
                    NavigationLink(value: destination) {
                        VStack(alignment: .leading) {
                            Text(destination.name)
                                .font(.headline)
                            
                            Text(destination.date.formatted(date: .long, time: .shortened))
                        }
                    }
                }
                .onDelete(perform: deleteDestinations)
            }
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .toolbar {
                Button("Add Samples", action: addSamples)
            }
        }
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
    
    func addSamples() {
        let rome = Destination(name: "Rome")
        let florence = Destination(name: "Florence")
        let naples = Destination(name: "Naples")
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
        
    }
}

#Preview {
    ContentView()
}
