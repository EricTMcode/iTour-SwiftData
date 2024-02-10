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
    @State private var path = [Destination]()
    @State private var sortOrder = [
        SortDescriptor(\Destination.name),
        SortDescriptor(\Destination.date)
    ]
    @State private var searchText = ""
    
    @State private var minimumDate = Date.distantPast
    let currentDate = Date.now
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationsListingView(sort: sortOrder,searchString: searchText, minimumDate: minimumDate)
                .navigationTitle("iTour")
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Destination", systemImage: "plus", action: addDestination)
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag([SortDescriptor(\Destination.name),
                                      SortDescriptor(\Destination.date)
                                     ])
                            
                            Text("Priority")
                                .tag([SortDescriptor(\Destination.priority, order: .reverse),
                                      SortDescriptor(\Destination.name)
                                     ])
                            
                            Text("Date")
                                .tag([SortDescriptor(\Destination.date),
                                      SortDescriptor(\Destination.name)
                                     ])
                        }
                        .pickerStyle(.inline)
                        
                        Picker("Filter", selection: $minimumDate) {
                            Text("Show all destinations")
                                .tag(Date.distantPast)
                            
                            Text("Show upcoming destinations")
                                .tag(currentDate)
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addDestination() {
        // Step 1 make an empty destination
        let destination = Destination()
        // Step 2 insert to the model context
        modelContext.insert(destination)
        // Step 3 push to the path
        path = [destination]
        
    }
}

#Preview {
    ContentView()
}
