import SwiftUI
import SwiftData

struct EmergencyPetInfoCard: View {
    @Query(sort: \Pet.sortOrder) private var pets: [Pet]
    @ObservedObject private var proSettings = ProSettings.shared
    @State private var isExpanded = false
    @State private var selectedPetIndex = 0

    var body: some View {
        if proSettings.isPro && !pets.isEmpty {
            VStack(spacing: 0) {
                // Collapsed header - always visible
                Button(action: {
                    withAnimation(.spring(response: 0.3)) {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "pawprint.fill")
                            .foregroundColor(Color("AccentColor"))

                        Text("My Pet Info")
                            .font(.headline)
                            .foregroundColor(.white)

                        Spacer()

                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                }

                // Expanded content
                if isExpanded {
                    VStack(spacing: 12) {
                        // Pet selector if multiple pets
                        if pets.count > 1 {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(Array(pets.enumerated()), id: \.element.id) { index, pet in
                                        petSelectorButton(pet: pet, index: index)
                                    }
                                }
                            }
                        }

                        // Selected pet's info
                        if selectedPetIndex < pets.count {
                            petInfoView(pet: pets[selectedPetIndex])
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.05))
                    .clipShape(
                        .rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 12,
                            bottomTrailingRadius: 12,
                            topTrailingRadius: 0
                        )
                    )
                }
            }
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    @ViewBuilder
    private func petSelectorButton(pet: Pet, index: Int) -> some View {
        Button(action: {
            selectedPetIndex = index
        }) {
            HStack(spacing: 6) {
                PetAvatarView(photoFilename: pet.photoFilename, size: 28)

                Text(pet.name)
                    .font(.subheadline)
                    .fontWeight(selectedPetIndex == index ? .semibold : .regular)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(selectedPetIndex == index ? Color("AccentColor").opacity(0.3) : Color.white.opacity(0.1))
            .clipShape(Capsule())
        }
        .foregroundColor(.white)
    }

    @ViewBuilder
    private func petInfoView(pet: Pet) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // Name and Species
            HStack {
                PetAvatarView(photoFilename: pet.photoFilename, size: 50)

                VStack(alignment: .leading, spacing: 2) {
                    Text(pet.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    Text(pet.speciesEnum.displayName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()
            }

            Divider()
                .background(Color.white.opacity(0.2))

            // Key info grid - the info poison control will ask for
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                if let breed = pet.breed, !breed.isEmpty {
                    infoItem(label: "Breed", value: breed)
                }

                if pet.weightLbs != nil {
                    infoItem(label: "Weight", value: pet.weightDisplayString)
                }

                if pet.birthday != nil {
                    infoItem(label: "Age", value: pet.ageDisplayString)
                }

                infoItem(label: "Sex", value: pet.sexEnum.displayName)
            }

            // Vet phone - prominent if available
            if let vetPhone = pet.vetPhone, !vetPhone.isEmpty {
                Divider()
                    .background(Color.white.opacity(0.2))

                Button(action: {
                    if let url = URL(string: "tel:\(vetPhone.filter { $0.isNumber })") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.green)

                        VStack(alignment: .leading) {
                            Text(pet.vetClinicName ?? "My Veterinarian")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(vetPhone)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }

                        Spacer()

                        Text("Call")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }
                    .padding(10)
                    .background(Color.green.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
    }

    @ViewBuilder
    private func infoItem(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ZStack {
        AppBackground()
        VStack {
            EmergencyPetInfoCard()
            Spacer()
        }
        .padding()
    }
    .modelContainer(for: Pet.self)
}
