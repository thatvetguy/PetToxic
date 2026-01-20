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

enum Severity: String, Codable, CaseIterable {
    case low
    case moderate
    case high
    case severe

    var displayName: String {
        rawValue.capitalized
    }

    var color: Color {
        switch self {
        case .low: return Color(red: 144/255, green: 238/255, blue: 144/255)
        case .moderate: return Color(red: 255/255, green: 215/255, blue: 0/255)
        case .high: return Color(red: 255/255, green: 165/255, blue: 0/255)
        case .severe: return Color(red: 255/255, green: 68/255, blue: 68/255)
        }
    }

    var description: String {
        switch self {
        case .low: return "Mild GI upset possible; monitor at home"
        case .moderate: return "Vet consultation recommended"
        case .high: return "Seek veterinary care promptly"
        case .severe: return "Potentially life-threatening; emergency care needed"
        }
    }
}

// MARK: - Category

enum Category: String, Codable, CaseIterable, Identifiable {
    case foods
    case plants
    case medications
    case cleaningProducts
    case essentialOils
    case garageGarden
    case recreationalSubstances
    case holidayHazards
    case environmentalHazards
    case householdItems
    case otherHazards
    case animalEncounters

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .foods: return "Foods"
        case .plants: return "Plants"
        case .medications: return "Medications"
        case .cleaningProducts: return "Cleaning Products"
        case .essentialOils: return "Essential Oils"
        case .garageGarden: return "Garage & Garden"
        case .recreationalSubstances: return "Recreational Substances"
        case .holidayHazards: return "Holiday Hazards"
        case .environmentalHazards: return "Environmental Hazards"
        case .householdItems: return "Household Items"
        case .otherHazards: return "Other Hazards"
        case .animalEncounters: return "Animal Encounters"
        }
    }

    var icon: String {
        switch self {
        case .foods: return "fork.knife"
        case .plants: return "leaf.fill"
        case .medications: return "pills.fill"
        case .cleaningProducts: return "bubbles.and.sparkles"
        case .essentialOils: return "drop.fill"
        case .garageGarden: return "wrench.and.screwdriver.fill"
        case .recreationalSubstances: return "smoke.fill"
        case .holidayHazards: return "gift.fill"
        case .environmentalHazards: return "exclamationmark.triangle.fill"
        case .householdItems: return "house.fill"
        case .otherHazards: return "exclamationmark.octagon.fill"
        case .animalEncounters: return "pawprint.fill"
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
