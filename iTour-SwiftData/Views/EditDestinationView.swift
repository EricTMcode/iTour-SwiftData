//
//  EditDestinationView.swift
//  iTour-SwiftData
//
//  Created by Eric on 09/02/2024.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditDestinationView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var destination: Destination
    @State private var newSighName = ""
    
    @State private var photosItem: PhotosPickerItem?
    
    var sortedSights: [Sight] {
        destination.sights.sorted {
            $0.name < $1.name
        }
    }
    
    var body: some View {
        Form {
            
            Section {
                if let imageDate = destination.image {
                    if let image = UIImage(data: imageDate) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                PhotosPicker("Attach a photo", selection: $photosItem, matching: .images)
            }
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Sights") {
                ForEach(sortedSights) { sight in
                    Text(sight.name)
                }
                .onDelete(perform: deleteSights)
                
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSighName)
                    
                    Button("Add", action: addSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: photosItem) {
            Task {
                destination.image = try? await photosItem?.loadTransferable(type: Data.self)
            }
        }
    }
    
    func addSight() {
        guard newSighName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSighName)
            destination.sights.append(sight)
            newSighName = ""
        }
    }
    
    func deleteSights(_ indexSet: IndexSet) {
        for index in indexSet {
            let sight = sortedSights[index]
            modelContext.delete(sight)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        
        let example = Destination(name: "Example Destination", details: "Example details go here and will automatically expand vertically as they are edited.")
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
