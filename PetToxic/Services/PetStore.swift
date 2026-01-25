import Foundation
import SwiftData
import SwiftUI

@Observable
class PetStore {
    static let maxPets = 5

    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // MARK: - CRUD Operations

    func fetchPets() -> [Pet] {
        let descriptor = FetchDescriptor<Pet>(
            sortBy: [SortDescriptor(\.sortOrder), SortDescriptor(\.dateCreated)]
        )
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Failed to fetch pets: \(error)")
            return []
        }
    }

    var canAddMorePets: Bool {
        fetchPets().count < Self.maxPets
    }

    var petCount: Int {
        fetchPets().count
    }

    func addPet(_ pet: Pet) {
        guard canAddMorePets else { return }

        // Set sort order to end of list
        let currentPets = fetchPets()
        pet.sortOrder = (currentPets.map(\.sortOrder).max() ?? -1) + 1

        modelContext.insert(pet)
        save()
    }

    func deletePet(_ pet: Pet) {
        modelContext.delete(pet)
        save()
    }

    func updatePet(_ pet: Pet) {
        pet.dateModified = Date()
        save()
    }

    func reorderPets(_ pets: [Pet]) {
        for (index, pet) in pets.enumerated() {
            pet.sortOrder = index
        }
        save()
    }

    private func save() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
}
