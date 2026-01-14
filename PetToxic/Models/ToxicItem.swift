import Foundation

struct ToxicItem: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let alternateNames: [String]
    let categories: [Category]
    let imageAsset: String?
    let description: String
    let toxicityInfo: String
    let symptoms: [String]
    let speciesRisks: [SpeciesRisk]
    let sources: [String]

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ToxicItem, rhs: ToxicItem) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Sample Data

extension ToxicItem {
    static let sample = ToxicItem(
        id: UUID(),
        name: "Chocolate",
        alternateNames: ["cocoa", "cacao", "dark chocolate", "milk chocolate", "baking chocolate"],
        categories: [.foods, .holidayHazards],
        imageAsset: "chocolate",
        description: "Chocolate is a food product made from roasted cacao beans, commonly found in candy, baked goods, and beverages.",
        toxicityInfo: "Chocolate contains theobromine and caffeine, both methylxanthines that dogs and cats cannot metabolize efficiently. Dark chocolate and baking chocolate contain higher concentrations and pose greater risk.",
        symptoms: [
            "Vomiting",
            "Diarrhea",
            "Increased thirst and urination",
            "Restlessness or hyperactivity",
            "Rapid breathing",
            "Muscle tremors",
            "Seizures (in severe cases)"
        ],
        speciesRisks: [
            SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are particularly sensitive to theobromine"),
            SpeciesRisk(species: .cat, severity: .high, notes: "Cats rarely consume chocolate but are equally sensitive")
        ],
        sources: [
            "ASPCA Animal Poison Control Center",
            "Merck Veterinary Manual"
        ]
    )
}
