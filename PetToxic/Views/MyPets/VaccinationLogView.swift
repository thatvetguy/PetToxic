import SwiftUI
import SwiftData

struct VaccinationLogView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var pet: Pet

    @State private var showingAddSheet = false
    @State private var recordToEdit: VaccinationRecord?

    private var sortedRecords: [VaccinationRecord] {
        pet.vaccinationRecords.sorted { a, b in
            let statusA = VaccinationStatus.from(nextDueDate: a.nextDueDate)
            let statusB = VaccinationStatus.from(nextDueDate: b.nextDueDate)
            let orderA = statusSortOrder(statusA)
            let orderB = statusSortOrder(statusB)
            if orderA != orderB {
                return orderA < orderB
            }
            // Within same status group, soonest due first
            let dateA = a.nextDueDate ?? .distantFuture
            let dateB = b.nextDueDate ?? .distantFuture
            return dateA < dateB
        }
    }

    var body: some View {
        List {
            // Disclaimer
            Section {
                HStack(alignment: .top, spacing: AppSpacing.sm) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(Color(hex: "856404"))
                        .font(.subheadline)

                    Text("This is a personal record-keeping tool. Always consult your veterinarian for vaccination schedules and recommendations.")
                        .font(.caption)
                        .foregroundColor(Color(hex: "856404"))
                }
                .padding(AppSpacing.md)
                .background(AppColors.Disclaimer.background)
                .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.small))
                .overlay(
                    RoundedRectangle(cornerRadius: AppCornerRadius.small)
                        .stroke(AppColors.Disclaimer.border, lineWidth: 1)
                )
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }

            // Records
            if sortedRecords.isEmpty {
                Section {
                    VStack(spacing: AppSpacing.md) {
                        Image(systemName: "syringe")
                            .font(.largeTitle)
                            .foregroundColor(.white.opacity(0.3))

                        Text("No vaccination records yet")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.6))

                        Text("Tap + to add one.")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.4))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppSpacing.xl)
                    .listRowBackground(Color.clear)
                }
            } else {
                Section {
                    ForEach(sortedRecords) { record in
                        VaccinationRecordRow(record: record)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                recordToEdit = record
                            }
                    }
                    .onDelete(perform: deleteRecords)
                }
            }
        }
        .navigationTitle("\(pet.name)'s Vaccinations")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            NavigationStack {
                AddEditVaccinationView(pet: pet)
            }
        }
        .sheet(item: $recordToEdit) { record in
            NavigationStack {
                AddEditVaccinationView(pet: pet, existingRecord: record)
            }
        }
    }

    private func deleteRecords(at offsets: IndexSet) {
        for index in offsets {
            let record = sortedRecords[index]
            modelContext.delete(record)
        }
        try? modelContext.save()
    }

    private func statusSortOrder(_ status: VaccinationStatus?) -> Int {
        switch status {
        case .overdue: return 0
        case .dueSoon: return 1
        case .current: return 2
        case nil: return 3
        }
    }
}

// MARK: - Record Row

private struct VaccinationRecordRow: View {
    let record: VaccinationRecord

    private var status: VaccinationStatus? {
        VaccinationStatus.from(nextDueDate: record.nextDueDate)
    }

    var body: some View {
        HStack(spacing: AppSpacing.md) {
            // Status icon
            if let status = status {
                Image(systemName: status.icon)
                    .foregroundColor(status.color)
                    .font(.title3)
            } else {
                Image(systemName: "circle.dotted")
                    .foregroundColor(.gray)
                    .font(.title3)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(record.vaccineName)
                    .font(.headline)

                HStack(spacing: 8) {
                    if let status = status {
                        Text(status.label)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(status.color)
                    }

                    Text("Given: \(record.dateAdministered, format: .dateTime.month(.abbreviated).day().year())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                if let nextDue = record.nextDueDate {
                    Text("Next due: \(nextDue, format: .dateTime.month(.abbreviated).day().year())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                if let notes = record.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Add/Edit Vaccination View

struct AddEditVaccinationView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let pet: Pet
    let existingRecord: VaccinationRecord?

    // Form state
    @State private var isCustomVaccine = false
    @State private var selectedPreset: VaccinePreset?
    @State private var customVaccineName = ""
    @State private var selectedInterval: BoosterInterval = .oneYear
    @State private var dateAdministered = Date()
    @State private var nextDueDate = Calendar.current.date(byAdding: .day, value: 365, to: Date()) ?? Date()
    @State private var userEditedNextDueDate = false
    @State private var notes = ""

    private var broadSpecies: Species? {
        BrowseFilterService.petSpeciesToToxicSpecies(pet.speciesEnum)
    }

    private var speciesPresetGroups: [(category: VaccineCategory, presets: [VaccinePreset])] {
        guard let species = broadSpecies else { return [] }
        return VaccinePresetData.groupedPresets(for: species)
    }

    private var hasPresets: Bool {
        !speciesPresetGroups.isEmpty
    }

    private var vaccineName: String {
        if isCustomVaccine {
            return customVaccineName.trimmingCharacters(in: .whitespaces)
        }
        return selectedPreset?.name ?? ""
    }

    private var canSave: Bool {
        !vaccineName.isEmpty && isDateValid
    }

    private var isDateValid: Bool {
        nextDueDate >= Calendar.current.startOfDay(for: dateAdministered)
    }

    private var isEditing: Bool {
        existingRecord != nil
    }

    init(pet: Pet, existingRecord: VaccinationRecord? = nil) {
        self.pet = pet
        self.existingRecord = existingRecord
    }

    var body: some View {
        Form {
            // MARK: Vaccine Selection
            Section("Vaccine") {
                if hasPresets {
                    Toggle("Custom vaccine", isOn: $isCustomVaccine)
                        .tint(.teal)
                        .onChange(of: isCustomVaccine) {
                            if isCustomVaccine {
                                selectedPreset = nil
                            }
                            recalculateNextDueDate()
                        }
                }

                if isCustomVaccine || !hasPresets {
                    TextField("Vaccine name", text: $customVaccineName)
                } else {
                    ForEach(speciesPresetGroups, id: \.category.rawValue) { group in
                        let header = group.category.rawValue
                        VStack(alignment: .leading, spacing: 0) {
                            Text(header)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.top, 8)

                            ForEach(group.presets) { preset in
                                Button {
                                    selectPreset(preset)
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(preset.name)
                                                .foregroundColor(.primary)

                                            if let subtitle = preset.subtitle {
                                                Text(subtitle)
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                        }

                                        Spacer()

                                        if selectedPreset?.name == preset.name {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.teal)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                }
            }

            // MARK: Interval Selection
            if let preset = selectedPreset, preset.hasMultipleIntervals, !isCustomVaccine {
                Section("Booster Interval") {
                    Picker("Interval", selection: $selectedInterval) {
                        ForEach(preset.intervals) { interval in
                            Text(interval.label).tag(interval)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedInterval) {
                        recalculateNextDueDate()
                    }
                }
            }

            // MARK: Dates
            Section("Dates") {
                DatePicker(
                    "Date Administered",
                    selection: $dateAdministered,
                    displayedComponents: .date
                )
                .onChange(of: dateAdministered) {
                    recalculateNextDueDate()
                }

                DatePicker(
                    "Next Due Date",
                    selection: $nextDueDate,
                    displayedComponents: .date
                )
                .onChange(of: nextDueDate) {
                    // Mark as user-edited only if this wasn't triggered by our recalculation
                    userEditedNextDueDate = true
                }

                if !isDateValid {
                    Text("Next due date must be on or after the date administered.")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            // MARK: Notes
            Section("Notes") {
                TextEditor(text: $notes)
                    .frame(minHeight: 60)
            }
        }
        .navigationTitle(isEditing ? "Edit Vaccination" : "Add Vaccination")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveRecord()
                }
                .disabled(!canSave)
                .fontWeight(.semibold)
            }
        }
        .onAppear {
            setupForEditing()
        }
    }

    // MARK: - Actions

    private func selectPreset(_ preset: VaccinePreset) {
        selectedPreset = preset
        selectedInterval = preset.defaultInterval
        userEditedNextDueDate = false
        recalculateNextDueDate()
    }

    private func recalculateNextDueDate() {
        guard !userEditedNextDueDate else { return }

        let interval: Int
        if isCustomVaccine || !hasPresets {
            interval = 365 // default 1 year for custom
        } else if let preset = selectedPreset {
            interval = selectedInterval.days
            _ = preset // silence warning
        } else {
            interval = 365
        }

        if let newDate = Calendar.current.date(byAdding: .day, value: interval, to: dateAdministered) {
            nextDueDate = newDate
        }

        // Reset the flag since we just programmatically set it
        userEditedNextDueDate = false
    }

    private func setupForEditing() {
        guard let record = existingRecord else {
            // New record: default to no presets for reptiles
            if !hasPresets {
                isCustomVaccine = true
            }
            return
        }

        // Populate from existing record
        dateAdministered = record.dateAdministered
        notes = record.notes ?? ""

        if let dueDate = record.nextDueDate {
            nextDueDate = dueDate
            userEditedNextDueDate = true // Don't overwrite user's saved date
        }

        // Try to match existing vaccine name to a preset
        if let species = broadSpecies {
            let presets = VaccinePresetData.presets(for: species)
            if let matchingPreset = presets.first(where: { $0.name == record.vaccineName }) {
                selectedPreset = matchingPreset
                isCustomVaccine = false

                // Try to determine which interval was used
                if let dueDate = record.nextDueDate {
                    let daysBetween = Calendar.current.dateComponents([.day], from: record.dateAdministered, to: dueDate).day ?? 365
                    // Find closest matching interval
                    if let closestInterval = matchingPreset.intervals.min(by: {
                        abs($0.days - daysBetween) < abs($1.days - daysBetween)
                    }) {
                        selectedInterval = closestInterval
                    }
                }
            } else {
                // Custom vaccine
                isCustomVaccine = true
                customVaccineName = record.vaccineName
            }
        } else {
            // Reptile or unknown species — custom mode
            isCustomVaccine = true
            customVaccineName = record.vaccineName
        }
    }

    private func saveRecord() {
        if let record = existingRecord {
            // Update existing
            record.vaccineName = vaccineName
            record.dateAdministered = dateAdministered
            record.nextDueDate = nextDueDate
            record.notes = notes.isEmpty ? nil : notes
        } else {
            // Create new — append to pet relationship, do NOT also insert into context
            let newRecord = VaccinationRecord(
                vaccineName: vaccineName,
                dateAdministered: dateAdministered,
                nextDueDate: nextDueDate,
                notes: notes.isEmpty ? nil : notes,
                pet: pet
            )
            pet.vaccinationRecords.append(newRecord)
        }

        try? modelContext.save()
        dismiss()
    }
}
