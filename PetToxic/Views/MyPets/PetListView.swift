import SwiftUI
import SwiftData

struct PetListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Pet.sortOrder), SortDescriptor(\Pet.dateCreated)]) private var pets: [Pet]

    @State private var showingAddPet = false

    var body: some View {
        NavigationStack {
            List {
                if pets.isEmpty {
                    ContentUnavailableView(
                        "No Pets Yet",
                        systemImage: "pawprint",
                        description: Text("Add your first pet to get started")
                    )
                } else {
                    ForEach(pets) { pet in
                        NavigationLink {
                            PetFormView(pet: pet, isNewPet: false)
                        } label: {
                            PetRowView(pet: pet)
                        }
                    }
                    .onDelete(perform: deletePets)
                    .onMove(perform: movePets)
                }
            }
            .navigationTitle("My Pets")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddPet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(pets.count >= PetStore.maxPets)
                }
            }
            .sheet(isPresented: $showingAddPet) {
                NavigationStack {
                    PetFormView(
                        pet: Pet(name: ""),
                        isNewPet: true
                    )
                }
            }
        }
    }

    private func deletePets(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(pets[index])
        }
    }

    private func movePets(from source: IndexSet, to destination: Int) {
        var mutablePets = pets
        mutablePets.move(fromOffsets: source, toOffset: destination)

        for (index, pet) in mutablePets.enumerated() {
            pet.sortOrder = index
        }
    }
}

struct PetRowView: View {
    let pet: Pet

    var body: some View {
        HStack(spacing: 12) {
            // Pet avatar
            PetAvatarView(photoFilename: pet.photoFilename, size: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(pet.name)
                    .font(.headline)

                Text(pet.speciesEnum.displayName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if let breed = pet.breed {
                    Text(breed)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            if pet.weightLbs != nil || pet.birthday != nil {
                VStack(alignment: .trailing, spacing: 4) {
                    if pet.weightLbs != nil {
                        Text(pet.weightDisplayString)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    if pet.birthday != nil {
                        Text(pet.ageDisplayString)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    PetListView()
        .modelContainer(for: Pet.self, inMemory: true)
}
