import SwiftUI
import SwiftData

struct EmergencyPetInfoCard: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Pet.sortOrder) private var pets: [Pet]
    @ObservedObject private var proSettings = ProSettings.shared
    @State private var isExpanded = false
    @State private var selectedPetIndex = 0
    @State private var newCaseNumber = ""
    @State private var showDeleteAlert = false
    @State private var caseToDelete: PoisonControlCase?
    @FocusState private var isCaseNumberFocused: Bool

    var body: some View {
        if !proSettings.isPro {
            // Locked placeholder for free users
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
                    HStack(spacing: 6) {
                        Text("My Pets")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.6))

                        Text("PRO")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(AppColors.teal.opacity(0.8))
                            .clipShape(Capsule())
                    }

                    Text("Your pet profiles appear here during emergencies")
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
        } else if proSettings.isPro && !pets.isEmpty {
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

            // Poison Control Case Numbers
            caseNumbersSection(pet: pet)
        }
    }

    @ViewBuilder
    private func caseNumbersSection(pet: Pet) -> some View {
        let sortedCases = pet.poisonControlCases.sorted { $0.dateAdded > $1.dateAdded }

        Divider()
            .background(Color.white.opacity(0.2))

        VStack(alignment: .leading, spacing: 8) {
            Text("Poison Control Case Numbers")
                .font(.caption)
                .foregroundColor(.gray)

            // Add new case number field
            HStack(spacing: 8) {
                TextField("Enter case number", text: $newCaseNumber)
                    .font(.subheadline)
                    .textFieldStyle(.plain)
                    .padding(8)
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .foregroundColor(.white)
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
                    .focused($isCaseNumberFocused)
                    .submitLabel(.done)
                    .onSubmit {
                        addCaseNumber(to: pet)
                    }

                if isCaseNumberFocused {
                    Button("Cancel") {
                        isCaseNumberFocused = false
                        newCaseNumber = ""
                    }
                    .foregroundColor(Color("AccentColor"))
                    .font(.subheadline)
                }

                Button(action: {
                    addCaseNumber(to: pet)
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                        .foregroundColor(newCaseNumber.trimmingCharacters(in: .whitespaces).isEmpty ? .gray : Color("AccentColor"))
                }
                .disabled(newCaseNumber.trimmingCharacters(in: .whitespaces).isEmpty)
            }

            // List of existing case numbers
            if !sortedCases.isEmpty {
                ForEach(sortedCases) { caseItem in
                    HStack(spacing: 8) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(caseItem.caseNumber)
                                .font(.system(.subheadline, design: .monospaced))
                                .fontWeight(.medium)
                                .foregroundColor(.white)

                            Text(caseItem.dateAdded, style: .date)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Button(action: {
                            copyToClipboard(caseItem.caseNumber)
                        }) {
                            Image(systemName: "doc.on.doc")
                                .font(.caption)
                                .foregroundColor(Color("AccentColor"))
                        }

                        Button(action: {
                            caseToDelete = caseItem
                            showDeleteAlert = true
                        }) {
                            Image(systemName: "trash")
                                .font(.caption)
                                .foregroundColor(.red.opacity(0.8))
                        }
                    }
                    .padding(8)
                    .background(Color.white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
        }
        .alert("Delete Case Number?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {
                caseToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let caseItem = caseToDelete {
                    deleteCaseNumber(caseItem)
                }
                caseToDelete = nil
            }
        } message: {
            if let caseItem = caseToDelete {
                Text("Delete case number \(caseItem.caseNumber)?")
            }
        }
    }

    private func addCaseNumber(to pet: Pet) {
        let trimmed = newCaseNumber.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }

        let newCase = PoisonControlCase(caseNumber: trimmed, pet: pet)
        modelContext.insert(newCase)
        pet.poisonControlCases.append(newCase)
        try? modelContext.save()
        newCaseNumber = ""
        isCaseNumberFocused = false
    }

    private func deleteCaseNumber(_ caseItem: PoisonControlCase) {
        modelContext.delete(caseItem)
        try? modelContext.save()
    }

    private func copyToClipboard(_ text: String) {
        UIPasteboard.general.string = text
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
    .modelContainer(for: [Pet.self, PoisonControlCase.self])
}
