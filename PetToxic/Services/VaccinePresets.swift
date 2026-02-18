import SwiftUI

// MARK: - Vaccination Status

enum VaccinationStatus {
    case current
    case dueSoon
    case overdue

    var label: String {
        switch self {
        case .current: return "Current"
        case .dueSoon: return "Due Soon"
        case .overdue: return "Overdue"
        }
    }

    var color: Color {
        switch self {
        case .current: return Color(red: 144/255, green: 238/255, blue: 144/255) // green
        case .dueSoon: return Color(hex: "FFA500") // orange
        case .overdue: return Color(hex: "FF4444") // red
        }
    }

    var icon: String {
        switch self {
        case .current: return "checkmark.circle.fill"
        case .dueSoon: return "exclamationmark.circle.fill"
        case .overdue: return "xmark.circle.fill"
        }
    }

    static func from(nextDueDate: Date?) -> VaccinationStatus? {
        guard let dueDate = nextDueDate else { return nil }
        let now = Date()
        if dueDate < now {
            return .overdue
        }
        let thirtyDaysFromNow = Calendar.current.date(byAdding: .day, value: 30, to: now) ?? now
        if dueDate <= thirtyDaysFromNow {
            return .dueSoon
        }
        return .current
    }
}

// MARK: - Booster Interval

struct BoosterInterval: Identifiable, Hashable {
    let id = UUID()
    let label: String
    let days: Int

    static let sixMonths = BoosterInterval(label: "6 Months", days: 182)
    static let oneYear = BoosterInterval(label: "1 Year", days: 365)
    static let threeYears = BoosterInterval(label: "3 Years", days: 1095)

    static func == (lhs: BoosterInterval, rhs: BoosterInterval) -> Bool {
        lhs.days == rhs.days
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(days)
    }
}

// MARK: - Vaccine Category

enum VaccineCategory: String {
    case core = "Core"
    case riskBased = "Risk-Based"
}

// MARK: - Vaccine Preset

struct VaccinePreset: Identifiable {
    let id = UUID()
    let name: String
    let subtitle: String?
    let category: VaccineCategory
    let species: Species
    let intervals: [BoosterInterval]
    let defaultInterval: BoosterInterval

    init(
        name: String,
        subtitle: String? = nil,
        category: VaccineCategory,
        species: Species,
        intervals: [BoosterInterval],
        defaultInterval: BoosterInterval? = nil
    ) {
        self.name = name
        self.subtitle = subtitle
        self.category = category
        self.species = species
        self.intervals = intervals
        self.defaultInterval = defaultInterval ?? intervals[0]
    }

    var hasMultipleIntervals: Bool {
        intervals.count > 1
    }
}

// MARK: - Preset Data

enum VaccinePresetData {
    static let all: [VaccinePreset] = dogVaccines + catVaccines + smallMammalVaccines + birdVaccines

    // MARK: Dog Vaccines (7)
    static let dogVaccines: [VaccinePreset] = [
        VaccinePreset(
            name: "Rabies",
            category: .core,
            species: .dog,
            intervals: [.oneYear, .threeYears],
            defaultInterval: .oneYear
        ),
        VaccinePreset(
            name: "DHPP",
            subtitle: "Also called DAPP or DA2PP — Distemper, Adenovirus, Parvo, Parainfluenza",
            category: .core,
            species: .dog,
            intervals: [.oneYear, .threeYears],
            defaultInterval: .oneYear
        ),
        VaccinePreset(
            name: "Bordetella",
            category: .riskBased,
            species: .dog,
            intervals: [.sixMonths, .oneYear],
            defaultInterval: .oneYear
        ),
        VaccinePreset(
            name: "Leptospirosis",
            category: .riskBased,
            species: .dog,
            intervals: [.oneYear]
        ),
        VaccinePreset(
            name: "Canine Influenza (CIV)",
            category: .riskBased,
            species: .dog,
            intervals: [.oneYear]
        ),
        VaccinePreset(
            name: "Lyme Disease",
            category: .riskBased,
            species: .dog,
            intervals: [.oneYear]
        ),
        VaccinePreset(
            name: "Rattlesnake Vaccine",
            category: .riskBased,
            species: .dog,
            intervals: [.sixMonths]
        ),
    ]

    // MARK: Cat Vaccines (3)
    static let catVaccines: [VaccinePreset] = [
        VaccinePreset(
            name: "Rabies",
            category: .core,
            species: .cat,
            intervals: [.oneYear, .threeYears],
            defaultInterval: .oneYear
        ),
        VaccinePreset(
            name: "FVRCP",
            subtitle: "Feline Viral Rhinotracheitis, Calicivirus, Panleukopenia",
            category: .core,
            species: .cat,
            intervals: [.oneYear, .threeYears],
            defaultInterval: .oneYear
        ),
        VaccinePreset(
            name: "FeLV",
            subtitle: "Feline Leukemia Virus",
            category: .riskBased,
            species: .cat,
            intervals: [.oneYear]
        ),
    ]

    // MARK: Small Mammal Vaccines (4)
    static let smallMammalVaccines: [VaccinePreset] = [
        VaccinePreset(
            name: "Rabies (Ferrets)",
            category: .riskBased,
            species: .smallMammal,
            intervals: [.oneYear]
        ),
        VaccinePreset(
            name: "Canine Distemper (Ferrets)",
            category: .riskBased,
            species: .smallMammal,
            intervals: [.oneYear]
        ),
        VaccinePreset(
            name: "RHDV2 (Rabbits)",
            subtitle: "Rabbit Hemorrhagic Disease Virus",
            category: .riskBased,
            species: .smallMammal,
            intervals: [.oneYear]
        ),
        VaccinePreset(
            name: "Myxomatosis (Rabbits)",
            category: .riskBased,
            species: .smallMammal,
            intervals: [.oneYear]
        ),
    ]

    // MARK: Bird Vaccines (1)
    static let birdVaccines: [VaccinePreset] = [
        VaccinePreset(
            name: "Polyomavirus",
            category: .riskBased,
            species: .bird,
            intervals: [.oneYear]
        ),
    ]

    /// Get presets for a given broad species
    static func presets(for species: Species) -> [VaccinePreset] {
        all.filter { $0.species == species }
    }

    /// Get presets grouped by category for a given species
    static func groupedPresets(for species: Species) -> [(category: VaccineCategory, presets: [VaccinePreset])] {
        let speciesPresets = presets(for: species)
        var groups: [(category: VaccineCategory, presets: [VaccinePreset])] = []

        let core = speciesPresets.filter { $0.category == .core }
        if !core.isEmpty {
            groups.append((.core, core))
        }

        let riskBased = speciesPresets.filter { $0.category == .riskBased }
        if !riskBased.isEmpty {
            groups.append((.riskBased, riskBased))
        }

        return groups
    }
}
