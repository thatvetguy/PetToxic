import SwiftUI
import SwiftData

struct PetListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(sort: [SortDescriptor(\Pet.sortOrder), SortDescriptor(\Pet.dateCreated)]) private var pets: [Pet]

    var presentedAsSheet: Bool = false
    @State private var showingAddPet = false



    var body: some View {
        List {
            if pets.isEmpty {
                Section {
                    VStack(spacing: 20) {
                        Image(systemName: "pawprint.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white.opacity(0.3))

                        Text("No pets added yet")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.7))

                        Button {
                            showingAddPet = true
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                Text("Add Your First Pet")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(AppColors.teal)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                    .listRowBackground(Color.clear)
                }
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

                // Add Pet button below pet cards
                if pets.count < PetStore.maxPets {
                    Section {
                        Button {
                            showingAddPet = true
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                Text("Add Pet")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(AppColors.teal.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppColors.teal.opacity(0.5), lineWidth: 1)
                            )
                        }
                        .buttonStyle(.plain)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.15, blue: 0.15),
                    Color(red: 0.02, green: 0.08, blue: 0.08)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationTitle("My Pets")
        .toolbar {
            if !pets.isEmpty {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }

            if presentedAsSheet {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                }
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
    NavigationStack {
        PetListView(presentedAsSheet: true)
    }
    .modelContainer(for: Pet.self, inMemory: true)
}
