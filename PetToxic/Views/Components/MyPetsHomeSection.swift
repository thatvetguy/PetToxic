import SwiftUI
import SwiftData

// MARK: - Main Section

struct MyPetsHomeSection: View {
    @ObservedObject private var proSettings = ProSettings.shared
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Pet.sortOrder), SortDescriptor(\Pet.dateCreated)]) private var pets: [Pet]

    @State private var selectedPet: Pet?
    @State private var showingAddPet = false
    @State private var showingPetList = false

    private var isPro: Bool { proSettings.isPro }


    var body: some View {
        VStack(spacing: 12) {
            // Section header
            HStack {
                Image(systemName: "pawprint.fill")
                    .foregroundColor(AppColors.teal)
                Text("My Pets")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()

                if !isPro {
                    Text("PRO")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppColors.teal.opacity(0.8))
                        .clipShape(Capsule())
                } else if !pets.isEmpty {
                    Button {
                        showingPetList = true
                    } label: {
                        Text("See All")
                            .font(.caption)
                            .foregroundColor(AppColors.teal)
                    }
                }
            }

            // Content based on state
            if !isPro {
                ProUpsellCard()
            } else if pets.isEmpty {
                EmptyPetsCard(showingAddPet: $showingAddPet)
            } else {
                PetCarousel(
                    pets: pets,
                    selectedPet: $selectedPet,
                    showingAddPet: $showingAddPet
                )

                if let pet = selectedPet {
                    PetExpandedCard(pet: pet, showingPetList: $showingPetList)
                        .transition(.asymmetric(
                            insertion: .scale(scale: 0.95).combined(with: .opacity),
                            removal: .opacity
                        ))
                }
            }
        }
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.2), value: selectedPet?.id)
        .sheet(isPresented: $showingAddPet) {
            NavigationStack {
                PetFormView(pet: Pet(name: ""), isNewPet: true)
            }
        }
        .sheet(isPresented: $showingPetList) {
            NavigationStack {
                PetListView(presentedAsSheet: true)
            }
        }
    }
}

// MARK: - Pro Upsell Card

private struct ProUpsellCard: View {


    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 60, height: 60)

                Image(systemName: "dog.fill")
                    .font(.title)
                    .foregroundColor(.white.opacity(0.3))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Upgrade to PRO")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.6))

                Text("Add your pets for quick access during emergencies")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.4))
            }

            Spacer()

            Image(systemName: "lock.fill")
                .foregroundColor(.white.opacity(0.3))
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .opacity(0.6)
    }
}

// MARK: - Empty Pets Card

private struct EmptyPetsCard: View {
    @Binding var showingAddPet: Bool


    var body: some View {
        Button {
            showingAddPet = true
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(AppColors.teal.opacity(0.2))
                        .frame(width: 60, height: 60)

                    Image(systemName: "plus")
                        .font(.title2.weight(.medium))
                        .foregroundColor(AppColors.teal)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Add your first pet")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)

                    Text("Quick access to pet info during emergencies")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding()
            .background(Color.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(AppColors.teal.opacity(0.3), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Pet Carousel

private struct PetCarousel: View {
    let pets: [Pet]
    @Binding var selectedPet: Pet?
    @Binding var showingAddPet: Bool



    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(pets) { pet in
                    PetAvatarButton(
                        pet: pet,
                        isSelected: selectedPet?.id == pet.id,
                        onTap: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                if selectedPet?.id == pet.id {
                                    selectedPet = nil
                                } else {
                                    selectedPet = pet
                                }
                            }
                        }
                    )
                }

                if pets.count < PetStore.maxPets {
                    AddPetButton(showingAddPet: $showingAddPet)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

// MARK: - Pet Avatar Button

private struct PetAvatarButton: View {
    let pet: Pet
    let isSelected: Bool
    let onTap: () -> Void



    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 6) {
                ZStack {
                    PetAvatarView(photoFilename: pet.photoFilename, size: 56)
                        .overlay(
                            Circle()
                                .stroke(isSelected ? AppColors.teal : Color.clear, lineWidth: 3)
                        )
                        .shadow(color: isSelected ? AppColors.teal.opacity(0.4) : .clear, radius: 8)
                }

                Text(pet.name)
                    .font(.caption2)
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundColor(isSelected ? AppColors.teal : .white.opacity(0.8))
                    .lineLimit(1)
                    .frame(width: 60)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Add Pet Button

private struct AddPetButton: View {
    @Binding var showingAddPet: Bool


    var body: some View {
        Button {
            showingAddPet = true
        } label: {
            VStack(spacing: 6) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 56, height: 56)

                    Circle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6, 4]))
                        .foregroundColor(AppColors.teal.opacity(0.5))
                        .frame(width: 56, height: 56)

                    Image(systemName: "plus")
                        .font(.title3.weight(.medium))
                        .foregroundColor(AppColors.teal.opacity(0.8))
                }

                Text("Add")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.6))
                    .frame(width: 60)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Pet Expanded Card

private struct PetExpandedCard: View {
    let pet: Pet
    @Binding var showingPetList: Bool



    var body: some View {
        VStack(spacing: 12) {
            // Pet info rows
            HStack(spacing: 16) {
                // Left column: Species & Breed
                VStack(alignment: .leading, spacing: 4) {
                    Label {
                        Text(pet.speciesEnum.displayName)
                            .font(.caption)
                            .foregroundColor(.white)
                    } icon: {
                        Image(systemName: speciesIcon)
                            .font(.caption)
                            .foregroundColor(AppColors.teal)
                    }

                    if let breed = pet.breed {
                        Text(breed)
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.6))
                            .lineLimit(1)
                    }
                }

                Spacer()

                // Right column: Weight & Age
                VStack(alignment: .trailing, spacing: 4) {
                    if pet.weightLbs != nil {
                        Text(pet.weightDisplayString)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }

                    if pet.birthday != nil {
                        HStack(spacing: 4) {
                            Text(pet.ageDisplayString)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                            if pet.isBirthdayApproximate {
                                Text("~")
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                    }
                }
            }

            // Vet info if available
            if let vetName = pet.vetClinicName, !vetName.isEmpty {
                HStack {
                    Image(systemName: "cross.case.fill")
                        .font(.caption)
                        .foregroundColor(AppColors.teal.opacity(0.8))

                    Text(vetName)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))

                    if let phone = pet.vetPhone, !phone.isEmpty {
                        Spacer()
                        Button {
                            callVet(phone: phone)
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "phone.fill")
                                Text("Call")
                            }
                            .font(.caption)
                            .foregroundColor(.green)
                        }
                    } else {
                        Spacer()
                    }
                }
            }

            // View Full Profile button
            Button {
                showingPetList = true
            } label: {
                HStack {
                    Text("View Full Profile")
                        .font(.caption)
                        .fontWeight(.medium)

                    Image(systemName: "chevron.right")
                        .font(.caption2)
                }
                .foregroundColor(AppColors.teal)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(AppColors.teal.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.teal.opacity(0.3), lineWidth: 1)
        )
    }

    private var speciesIcon: String {
        switch pet.speciesEnum {
        case .canine:
            return "dog.fill"
        case .feline:
            return "cat.fill"
        case .parakeet, .cockatiel, .parrot, .canary, .finch, .lovebird, .conure, .cockatoo, .macaw, .africanGrey, .otherBird:
            return "bird.fill"
        case .rabbit:
            return "hare.fill"
        case .hamster, .guineaPig, .gerbil, .mouse, .rat, .chinchilla, .ferret, .hedgehog, .sugarGlider, .otherSmallMammal:
            return "pawprint.fill"
        case .beardedDragon, .leopardGecko, .ballPython, .cornSnake, .turtle, .tortoise, .iguana, .chameleon, .blueTonguedSkink, .otherReptile:
            return "lizard.fill"
        }
    }

    private func callVet(phone: String) {
        let cleaned = phone.filter { $0.isNumber }
        guard let url = URL(string: "tel://\(cleaned)") else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - Preview

#Preview("With Pets") {
    ZStack {
        AppBackground()
        MyPetsHomeSection()
    }
    .modelContainer(for: Pet.self, inMemory: true)
}

#Preview("Empty") {
    ZStack {
        AppBackground()
        MyPetsHomeSection()
    }
    .modelContainer(for: Pet.self, inMemory: true)
}
