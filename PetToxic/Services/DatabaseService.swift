import Foundation

class DatabaseService {
    static let shared = DatabaseService()

    private var allItems: [ToxicItem] = []

    private init() {
        loadSampleData()
    }

    private func loadSampleData() {
        // Sample data for development - will be replaced with SQLite database
        allItems = [
            ToxicItem(
                id: UUID(),
                name: "Chocolate",
                alternateNames: ["cocoa", "cacao", "dark chocolate", "milk chocolate", "baking chocolate"],
                categories: [.foods, .holidayHazards],
                imageAsset: nil,
                description: "Chocolate is a food product made from roasted cacao beans.",
                toxicityInfo: "Contains theobromine and caffeine that dogs and cats cannot metabolize efficiently.",
                symptoms: ["Vomiting", "Diarrhea", "Increased thirst", "Restlessness", "Rapid breathing", "Muscle tremors", "Seizures"],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are particularly sensitive to theobromine"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Cats rarely consume chocolate but are equally sensitive")
                ],
                sources: ["ASPCA Animal Poison Control Center", "Merck Veterinary Manual"]
            ),
            ToxicItem(
                id: UUID(),
                name: "Grapes",
                alternateNames: ["raisins", "currants", "grape juice"],
                categories: [.foods],
                imageAsset: nil,
                description: "Grapes and raisins are common fruits that can be highly toxic to dogs.",
                toxicityInfo: "The exact toxic substance is unknown, but can cause acute kidney failure in dogs.",
                symptoms: ["Vomiting", "Diarrhea", "Lethargy", "Loss of appetite", "Decreased urination", "Abdominal pain"],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Can cause kidney failure even in small amounts"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Less commonly affected but still at risk")
                ],
                sources: ["ASPCA Animal Poison Control Center", "VCA Hospitals"]
            ),
            ToxicItem(
                id: UUID(),
                name: "Xylitol",
                alternateNames: ["birch sugar", "sugar-free sweetener", "E967"],
                categories: [.foods],
                imageAsset: nil,
                description: "Xylitol is an artificial sweetener found in sugar-free products.",
                toxicityInfo: "Causes rapid insulin release in dogs, leading to hypoglycemia. Can also cause liver failure.",
                symptoms: ["Vomiting", "Weakness", "Difficulty walking", "Collapse", "Seizures", "Liver failure"],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Extremely toxic to dogs"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Cats appear less sensitive")
                ],
                sources: ["ASPCA Animal Poison Control Center", "FDA"]
            ),
            ToxicItem(
                id: UUID(),
                name: "Lily",
                alternateNames: ["Easter lily", "Tiger lily", "Asiatic lily", "Daylily", "Stargazer lily"],
                categories: [.plants, .holidayHazards],
                imageAsset: nil,
                description: "Lilies are flowering plants commonly found in gardens and floral arrangements.",
                toxicityInfo: "All parts of true lilies are extremely toxic to cats and can cause acute kidney failure.",
                symptoms: ["Vomiting", "Lethargy", "Loss of appetite", "Kidney failure", "Death"],
                speciesRisks: [
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Extremely toxic - even small amounts can be fatal"),
                    SpeciesRisk(species: .dog, severity: .low, notes: "Generally not toxic to dogs")
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline"]
            ),
            ToxicItem(
                id: UUID(),
                name: "Acetaminophen",
                alternateNames: ["Tylenol", "paracetamol", "APAP"],
                categories: [.humanMedications],
                imageAsset: nil,
                description: "Acetaminophen is a common over-the-counter pain reliever and fever reducer.",
                toxicityInfo: "Damages red blood cells and liver in pets. Cats are extremely sensitive.",
                symptoms: ["Brown gums", "Difficulty breathing", "Swollen face/paws", "Vomiting", "Liver failure"],
                speciesRisks: [
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats lack enzymes to metabolize - one pill can be fatal"),
                    SpeciesRisk(species: .dog, severity: .high, notes: "Toxic at lower doses than humans")
                ],
                sources: ["ASPCA Animal Poison Control Center", "Merck Veterinary Manual"]
            ),
            ToxicItem(
                id: UUID(),
                name: "Ibuprofen",
                alternateNames: ["Advil", "Motrin", "Nurofen"],
                categories: [.humanMedications],
                imageAsset: nil,
                description: "Ibuprofen is a nonsteroidal anti-inflammatory drug (NSAID) used for pain relief.",
                toxicityInfo: "Can cause stomach ulcers, kidney failure, and neurological problems in pets.",
                symptoms: ["Vomiting", "Diarrhea", "Bloody stool", "Increased thirst", "Seizures", "Kidney failure"],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Toxic at much lower doses than humans"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are extremely sensitive to NSAIDs")
                ],
                sources: ["ASPCA Animal Poison Control Center", "VCA Hospitals"]
            ),
            ToxicItem(
                id: UUID(),
                name: "Antifreeze",
                alternateNames: ["ethylene glycol", "coolant", "radiator fluid"],
                categories: [.garageAutomotive],
                imageAsset: nil,
                description: "Antifreeze is a liquid used in vehicle cooling systems.",
                toxicityInfo: "Ethylene glycol is metabolized into toxic compounds that cause kidney failure. Has a sweet taste attractive to pets.",
                symptoms: ["Wobbly gait", "Excessive thirst", "Vomiting", "Seizures", "Kidney failure", "Coma"],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Extremely toxic - small amounts can be fatal"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Just 1 teaspoon can be fatal to a cat")
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline"]
            ),
            ToxicItem(
                id: UUID(),
                name: "Onions",
                alternateNames: ["garlic", "leeks", "chives", "shallots", "scallions"],
                categories: [.foods],
                imageAsset: nil,
                description: "Onions and related allium vegetables are common cooking ingredients.",
                toxicityInfo: "Contains compounds that damage red blood cells, causing hemolytic anemia.",
                symptoms: ["Vomiting", "Diarrhea", "Lethargy", "Pale gums", "Weakness", "Rapid breathing"],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Toxic in larger amounts"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Cats are more sensitive than dogs")
                ],
                sources: ["ASPCA Animal Poison Control Center", "Merck Veterinary Manual"]
            )
        ]
    }

    func allToxicItems() -> [ToxicItem] {
        allItems
    }

    func items(for category: Category) -> [ToxicItem] {
        allItems.filter { $0.categories.contains(category) }
    }

    func item(withId id: UUID) -> ToxicItem? {
        allItems.first { $0.id == id }
    }

    func search(query: String, species: [Species]?) -> [ToxicItem] {
        let lowercasedQuery = query.lowercased()

        var results = allItems.filter { item in
            item.name.lowercased().contains(lowercasedQuery) ||
            item.alternateNames.contains { $0.lowercased().contains(lowercasedQuery) }
        }

        if let species = species, !species.isEmpty {
            results = results.filter { item in
                item.speciesRisks.contains { species.contains($0.species) }
            }
        }

        return results
    }
}
