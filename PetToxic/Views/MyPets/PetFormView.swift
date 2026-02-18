import SwiftUI
import SwiftData
import UIKit
import AVFoundation

struct PetFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Bindable var pet: Pet
    let isNewPet: Bool

    @State private var showingDeleteAlert = false
    @State private var showingSavedIndicator = false

    // Case number management
    @State private var newCaseNumber = ""
    @State private var showAddCaseNoteAlert = false
    @State private var pendingCaseNumber = ""
    @State private var caseNote = ""
    @State private var showDeleteCaseAlert = false
    @State private var caseToDelete: PoisonControlCase?
    @State private var showEditCaseAlert = false
    @State private var caseToEdit: PoisonControlCase?
    @State private var editCaseNumber = ""
    @State private var editCaseNote = ""

    // Weight input
    @State private var weightInput: String = ""
    @State private var weightUnit: WeightUnit = .lbs

    // Birthday input
    @State private var birthdayMode: BirthdayMode = .exact
    @State private var ageYears: Int = 0
    @State private var ageMonths: Int = 0

    // Breed autocomplete
    @State private var breedSearchText: String = ""
    @State private var breedSuggestions: [String] = []
    @State private var showBreedSuggestions: Bool = false

    // Photo
    @State private var showPhotoPicker = false
    @State private var currentPhoto: UIImage?

    enum WeightUnit: String, CaseIterable {
        case lbs, kg
    }

    enum BirthdayMode: String, CaseIterable {
        case exact = "Exact Date"
        case approximate = "Approximate Age"
    }

    init(pet: Pet, isNewPet: Bool = false) {
        self.pet = pet
        self.isNewPet = isNewPet
    }

    var body: some View {
        Form {
            // MARK: - Photo Section
            Section {
                HStack {
                    Spacer()

                    Button {
                        showPhotoPicker = true
                    } label: {
                        VStack(spacing: 8) {
                            if let photo = currentPhoto {
                                Image(uiImage: photo)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.accentColor, lineWidth: 3)
                                    )
                            } else {
                                PetAvatarView(photoFilename: pet.photoFilename, size: 120)
                            }

                            Text(currentPhoto != nil || pet.photoFilename != nil ? "Change Photo" : "Add Photo")
                                .font(.caption)
                                .foregroundColor(.accentColor)
                        }
                    }
                    .buttonStyle(.plain)

                    Spacer()
                }
                .listRowBackground(Color.clear)
            }

            // MARK: - Basic Information
            Section("Basic Information") {
                TextField("Name *", text: $pet.name)
                    .onChange(of: pet.name) { triggerAutoSave() }

                TextField("Nickname", text: Binding(
                    get: { pet.nickname ?? "" },
                    set: { pet.nickname = $0.isEmpty ? nil : $0 }
                ))
                .onChange(of: pet.nickname) { triggerAutoSave() }

                // Species Picker
                Picker("Species", selection: $pet.speciesEnum) {
                    ForEach(PetSpecies.grouped, id: \.category) { group in
                        Section(group.category.rawValue) {
                            ForEach(group.species, id: \.self) { species in
                                Text(species.displayName).tag(species)
                            }
                        }
                    }
                }
                .pickerStyle(.navigationLink)
                .onChange(of: pet.speciesEnum) { triggerAutoSave() }

                // Breed with Autocomplete
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Breed", text: $breedSearchText)
                        .onChange(of: breedSearchText) { _, newValue in
                            updateBreedSuggestions(query: newValue)
                            pet.breed = newValue.isEmpty ? nil : newValue
                            triggerAutoSave()
                        }
                        .onChange(of: pet.speciesEnum) { _, _ in
                            // Clear breed when species changes
                            breedSearchText = ""
                            pet.breed = nil
                            breedSuggestions = []
                        }

                    // Autocomplete suggestions
                    if showBreedSuggestions && !breedSuggestions.isEmpty {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(breedSuggestions, id: \.self) { suggestion in
                                    Button {
                                        selectBreed(suggestion)
                                    } label: {
                                        Text(suggestion)
                                            .foregroundColor(.primary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 8)
                                    }
                                    Divider()
                                }
                            }
                        }
                        .frame(maxHeight: 200)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                }

                // Sex Picker
                Picker("Sex", selection: $pet.sexEnum) {
                    ForEach(PetSex.allCases, id: \.self) { sex in
                        Text(sex.displayName).tag(sex)
                    }
                }
                .pickerStyle(.navigationLink)
                .onChange(of: pet.sexEnum) { triggerAutoSave() }
            }

            // MARK: - Physical Details
            Section("Physical Details") {
                // Weight Input
                HStack {
                    TextField("Weight", text: $weightInput)
                        .keyboardType(.decimalPad)
                        .onChange(of: weightInput) { updateWeight() }

                    Picker("Unit", selection: $weightUnit) {
                        ForEach(WeightUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 100)
                    .onChange(of: weightUnit) { convertWeightUnit() }
                }

                if pet.weightLbs != nil {
                    Text(pet.weightDisplayString)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                // Birthday / Age
                Picker("Birthday", selection: $birthdayMode) {
                    ForEach(BirthdayMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)

                if birthdayMode == .exact {
                    DatePicker(
                        "Birthday",
                        selection: Binding(
                            get: { pet.birthday ?? Date() },
                            set: {
                                pet.birthday = $0
                                pet.isBirthdayApproximate = false
                                triggerAutoSave()
                            }
                        ),
                        displayedComponents: .date
                    )
                } else {
                    Stepper("Years: \(ageYears)", value: $ageYears, in: 0...30)
                        .onChange(of: ageYears) { updateApproximateBirthday() }
                    Stepper("Months: \(ageMonths)", value: $ageMonths, in: 0...11)
                        .onChange(of: ageMonths) { updateApproximateBirthday() }
                }

                if pet.birthday != nil {
                    HStack {
                        Text("Age:")
                        Text(pet.ageDisplayString)
                            .foregroundColor(.secondary)
                        if pet.isBirthdayApproximate {
                            Text("(approx)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }

            // MARK: - Medical & Emergency
            Section("Medical & Emergency") {
                TextField("Microchip #", text: Binding(
                    get: { pet.microchipNumber ?? "" },
                    set: { pet.microchipNumber = $0.isEmpty ? nil : $0 }
                ))
                .onChange(of: pet.microchipNumber) { triggerAutoSave() }

                TextField("Vet Clinic Name", text: Binding(
                    get: { pet.vetClinicName ?? "" },
                    set: { pet.vetClinicName = $0.isEmpty ? nil : $0 }
                ))
                .onChange(of: pet.vetClinicName) { triggerAutoSave() }

                HStack {
                    TextField("Vet Phone", text: Binding(
                        get: { pet.vetPhone ?? "" },
                        set: { pet.vetPhone = $0.isEmpty ? nil : $0 }
                    ))
                    .keyboardType(.phonePad)
                    .onChange(of: pet.vetPhone) { triggerAutoSave() }

                    if let phone = pet.vetPhone, !phone.isEmpty {
                        Button {
                            callVet()
                        } label: {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.green)
                        }
                    }
                }

                // Notes (multiline)
                VStack(alignment: .leading) {
                    Text("Notes")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextEditor(text: Binding(
                        get: { pet.notes ?? "" },
                        set: { pet.notes = $0.isEmpty ? nil : $0 }
                    ))
                    .frame(minHeight: 80)
                    .onChange(of: pet.notes) { triggerAutoSave() }
                }
            }

            // MARK: - Poison Control Case Numbers
            Section("Poison Control Case Numbers") {
                // Add new case number
                HStack(spacing: 8) {
                    TextField("Case number", text: $newCaseNumber)
                        .textInputAutocapitalization(.characters)
                        .autocorrectionDisabled()

                    Button {
                        promptForCaseNote()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(newCaseNumber.trimmingCharacters(in: .whitespaces).isEmpty ? .gray : .accentColor)
                    }
                    .disabled(newCaseNumber.trimmingCharacters(in: .whitespaces).isEmpty)
                }

                // List existing case numbers
                let sortedCases = pet.poisonControlCases.sorted { $0.dateAdded > $1.dateAdded }
                ForEach(sortedCases) { caseItem in
                    Button {
                        startEditingCase(caseItem)
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(caseItem.caseNumber)
                                    .font(.system(.body, design: .monospaced))
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)

                                HStack(spacing: 4) {
                                    Text(caseItem.dateAdded, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)

                                    if let note = caseItem.note, !note.isEmpty {
                                        Text("•")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text(note)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                }
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            caseToDelete = caseItem
                            showDeleteCaseAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            copyToClipboard(caseItem.caseNumber)
                        } label: {
                            Label("Copy", systemImage: "doc.on.doc")
                        }
                        .tint(.blue)
                    }
                }

                if sortedCases.isEmpty {
                    Text("No case numbers saved")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .italic()
                }
            }

            // MARK: - Vaccination Records
            if !isNewPet {
                Section("Vaccination Records") {
                    NavigationLink {
                        VaccinationLogView(pet: pet)
                    } label: {
                        HStack {
                            Image(systemName: "syringe.fill")
                                .foregroundColor(.teal)
                            Text("Vaccinations")
                            Spacer()
                            let count = pet.vaccinationRecords.count
                            if count > 0 {
                                Text("\(count)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(Color(.systemGray5))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
            }

            // MARK: - Browse Filter
            Section {
                Toggle(isOn: $pet.prioritizeInBrowse) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Prioritize in browse filter")
                            .font(.subheadline)
                        Text("Browse will default to showing entries relevant to \(pet.speciesEnum.displayName.lowercased())")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .tint(.teal)
                .onChange(of: pet.prioritizeInBrowse) { triggerAutoSave() }
            }

            // MARK: - Delete Button (only for existing pets)
            if !isNewPet {
                Section {
                    Button(role: .destructive) {
                        showingDeleteAlert = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete Pet")
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationTitle(isNewPet ? "Add Pet" : pet.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if showingSavedIndicator {
                    Text("Saved")
                        .font(.caption)
                        .foregroundColor(.green)
                        .transition(.opacity)
                }
            }

            if isNewPet {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        savePet()
                    }
                    .disabled(pet.name.isEmpty)
                }
            }
        }
        .alert("Delete \(pet.name)?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                deletePet()
            }
        } message: {
            Text("This cannot be undone.")
        }
        .alert("Add Note?", isPresented: $showAddCaseNoteAlert) {
            TextField("Note (optional)", text: $caseNote)
            Button("Skip") {
                addCaseNumber(withNote: false)
            }
            Button("Save") {
                addCaseNumber(withNote: true)
            }
        } message: {
            Text("Add an optional note for case \(pendingCaseNumber)")
        }
        .alert("Edit Case Number", isPresented: $showEditCaseAlert) {
            TextField("Case number", text: $editCaseNumber)
            TextField("Note (optional)", text: $editCaseNote)
            Button("Cancel", role: .cancel) {
                caseToEdit = nil
            }
            Button("Save") {
                saveEditedCase()
            }
        }
        .alert("Delete Case Number?", isPresented: $showDeleteCaseAlert) {
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
        .scrollDismissesKeyboard(.interactively)
        .safeAreaPadding(.bottom, 80)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    hideKeyboard()
                }
            }
        }
        .onAppear {
            setupInitialValues()
        }
        .sheet(isPresented: $showPhotoPicker) {
            PetPhotoPickerView(
                selectedImage: $currentPhoto,
                onImageSelected: { image in
                    handlePhotoSelection(image)
                }
            )
        }
    }

    // MARK: - Helper Methods

    private func setupInitialValues() {
        // Load existing photo
        if let filename = pet.photoFilename {
            currentPhoto = PetPhotoService.shared.loadPhoto(filename: filename)
        }

        // Set up weight input
        if let lbs = pet.weightLbs {
            weightInput = String(format: "%.1f", lbs)
            weightUnit = .lbs
        }

        // Set up breed search text
        breedSearchText = pet.breed ?? ""

        // Set up birthday mode
        if pet.birthday != nil {
            if pet.isBirthdayApproximate {
                birthdayMode = .approximate
                if let age = pet.age {
                    ageYears = age.years
                    ageMonths = age.months
                }
            } else {
                birthdayMode = .exact
            }
        }
    }

    private func updateWeight() {
        guard let value = Double(weightInput) else {
            pet.weightLbs = nil
            return
        }

        if weightUnit == .lbs {
            pet.weightLbs = value
        } else {
            pet.weightLbs = value * 2.20462  // Convert kg to lbs for storage
        }
        triggerAutoSave()
    }

    private func convertWeightUnit() {
        guard let currentLbs = pet.weightLbs else { return }

        if weightUnit == .kg {
            let kg = currentLbs / 2.20462
            weightInput = String(format: "%.1f", kg)
        } else {
            weightInput = String(format: "%.1f", currentLbs)
        }
    }

    private func updateApproximateBirthday() {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = -ageYears
        components.month = -ageMonths

        if let date = calendar.date(byAdding: components, to: Date()) {
            pet.birthday = date
            pet.isBirthdayApproximate = true
            triggerAutoSave()
        }
    }

    private func triggerAutoSave() {
        guard !isNewPet else { return }  // Don't auto-save new pets

        pet.dateModified = Date()
        try? modelContext.save()

        // Show saved indicator
        withAnimation {
            showingSavedIndicator = true
        }

        // Hide after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showingSavedIndicator = false
            }
        }
    }

    private func savePet() {
        modelContext.insert(pet)
        try? modelContext.save()
        dismiss()
    }

    private func deletePet() {
        // Delete photo file
        if let filename = pet.photoFilename {
            PetPhotoService.shared.deletePhoto(filename: filename)
        }

        modelContext.delete(pet)
        try? modelContext.save()
        dismiss()
    }

    private func handlePhotoSelection(_ image: UIImage) {
        // Check if this is a "remove" action (empty image)
        if image.size == .zero {
            // Delete existing photo
            if let filename = pet.photoFilename {
                PetPhotoService.shared.deletePhoto(filename: filename)
            }
            pet.photoFilename = nil
            currentPhoto = nil
            triggerAutoSave()
            return
        }

        // Save new photo
        currentPhoto = image

        if let filename = PetPhotoService.shared.savePhoto(image, for: pet.id) {
            // Delete old photo if exists
            if let oldFilename = pet.photoFilename, oldFilename != filename {
                PetPhotoService.shared.deletePhoto(filename: oldFilename)
            }
            pet.photoFilename = filename
            triggerAutoSave()
        }
    }

    private func callVet() {
        guard let phone = pet.vetPhone,
              let url = URL(string: "tel://\(phone.filter { $0.isNumber })") else { return }
        UIApplication.shared.open(url)
    }

    private func updateBreedSuggestions(query: String) {
        let suggestions = BreedService.shared.searchBreeds(
            query: query,
            for: pet.speciesEnum
        )
        breedSuggestions = suggestions
        showBreedSuggestions = !query.isEmpty && !suggestions.isEmpty
    }

    private func selectBreed(_ breed: String) {
        breedSearchText = breed
        pet.breed = breed
        showBreedSuggestions = false
        hideKeyboard()
        triggerAutoSave()
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    // MARK: - Case Number Methods

    private func promptForCaseNote() {
        let trimmed = newCaseNumber.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        pendingCaseNumber = trimmed
        caseNote = ""
        showAddCaseNoteAlert = true
    }

    private func addCaseNumber(withNote: Bool) {
        let newCase = PoisonControlCase(
            caseNumber: pendingCaseNumber,
            note: withNote && !caseNote.isEmpty ? caseNote : nil,
            pet: pet
        )
        modelContext.insert(newCase)
        pet.poisonControlCases.append(newCase)
        newCaseNumber = ""
        pendingCaseNumber = ""
        caseNote = ""
        triggerAutoSave()
    }

    private func startEditingCase(_ caseItem: PoisonControlCase) {
        caseToEdit = caseItem
        editCaseNumber = caseItem.caseNumber
        editCaseNote = caseItem.note ?? ""
        showEditCaseAlert = true
    }

    private func saveEditedCase() {
        guard let caseItem = caseToEdit else { return }
        let trimmed = editCaseNumber.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }

        caseItem.caseNumber = trimmed
        caseItem.note = editCaseNote.isEmpty ? nil : editCaseNote
        caseToEdit = nil
        editCaseNumber = ""
        editCaseNote = ""
        triggerAutoSave()
    }

    private func deleteCaseNumber(_ caseItem: PoisonControlCase) {
        modelContext.delete(caseItem)
        triggerAutoSave()
    }

    private func copyToClipboard(_ text: String) {
        UIPasteboard.general.string = text
    }
}

#Preview {
    NavigationStack {
        PetFormView(pet: Pet(name: "Bella", species: .canine), isNewPet: true)
    }
    .modelContainer(for: [Pet.self, PoisonControlCase.self], inMemory: true)
}
