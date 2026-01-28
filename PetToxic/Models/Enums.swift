import SwiftUI

// MARK: - Species

enum Species: String, Codable, CaseIterable, Identifiable {
    case dog
    case cat
    case smallMammal
    case bird
    case reptile

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .dog: return "Dogs"
        case .cat: return "Cats"
        case .smallMammal: return "Small Mammals"
        case .bird: return "Birds"
        case .reptile: return "Reptiles"
        }
    }

    var icon: String {
        switch self {
        case .dog: return "dog"
        case .cat: return "cat"
        case .smallMammal: return "hare"
        case .bird: return "bird"
        case .reptile: return "lizard"
        }
    }
}

// MARK: - Severity

enum Severity: String, Codable, CaseIterable, Comparable {
    case low
    case lowModerate
    case moderate
    case high
    case severe

    var displayName: String {
        switch self {
        case .low: return "Low"
        case .lowModerate: return "Low-Moderate"
        case .moderate: return "Moderate"
        case .high: return "High"
        case .severe: return "Severe"
        }
    }

    var color: Color {
        switch self {
        case .low: return Color(red: 144/255, green: 238/255, blue: 144/255)
        case .lowModerate: return Color(red: 255/255, green: 222/255, blue: 50/255)  // #FFDE32
        case .moderate: return Color(red: 255/255, green: 215/255, blue: 0/255)
        case .high: return Color(red: 255/255, green: 165/255, blue: 0/255)
        case .severe: return Color(red: 255/255, green: 68/255, blue: 68/255)
        }
    }

    var description: String {
        switch self {
        case .low: return "Mild GI upset possible; monitor at home"
        case .lowModerate: return "May cause mild to moderate effects; monitor closely"
        case .moderate: return "Vet consultation recommended"
        case .high: return "Seek veterinary care promptly"
        case .severe: return "Potentially life-threatening; emergency care needed"
        }
    }

    // MARK: - Comparable

    private var sortOrder: Int {
        switch self {
        case .low: return 1
        case .lowModerate: return 2
        case .moderate: return 3
        case .high: return 4
        case .severe: return 5
        }
    }

    static func < (lhs: Severity, rhs: Severity) -> Bool {
        lhs.sortOrder < rhs.sortOrder
    }
}

// MARK: - Category

enum Category: String, Codable, CaseIterable, Identifiable {
    case foods
    case plants
    case medications
    case cleaningProducts
    case garageGarden
    case recreationalSubstances
    case holidayHazards
    case householdItems
    case outdoorHazards
    case informational

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .foods: return "Foods"
        case .plants: return "Plants"
        case .medications: return "Medications"
        case .cleaningProducts: return "Cleaning Products"
        case .garageGarden: return "Garage & Garden"
        case .recreationalSubstances: return "Recreational Substances"
        case .holidayHazards: return "Holiday Hazards"
        case .householdItems: return "Household Items"
        case .outdoorHazards: return "Outdoor Hazards"
        case .informational: return "Informational"
        }
    }

    var icon: String {
        switch self {
        case .foods: return "fork.knife"
        case .plants: return "leaf.fill"
        case .medications: return "pills.fill"
        case .cleaningProducts: return "bubbles.and.sparkles"
        case .garageGarden: return "wrench.and.screwdriver.fill"
        case .recreationalSubstances: return "smoke.fill"
        case .holidayHazards: return "gift.fill"
        case .householdItems: return "house.fill"
        case .outdoorHazards: return "figure.hiking"
        case .informational: return "info.circle.fill"
        }
    }
}

// MARK: - Match Type

enum MatchType: String, Codable {
    case exact
    case prefix
    case fuzzy
    case synonym
}
