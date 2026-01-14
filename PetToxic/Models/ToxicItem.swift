import Foundation

// MARK: - OnsetTime

struct OnsetTime: Codable, Hashable {
    let early: String?
    let delayed: String?
}

// MARK: - ToxicItem

struct ToxicItem: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let alternateNames: [String]
    let categories: [Category]
    let imageAsset: String?
    let description: String
    let toxicityInfo: String
    let onsetTime: OnsetTime?
    let symptoms: [String]
    let speciesRisks: [SpeciesRisk]
    let preventionTips: [String]?
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
        alternateNames: ["cocoa", "cacao", "dark chocolate", "milk chocolate", "baking chocolate", "white chocolate", "cocoa powder", "chocolate chips", "cocoa bean mulch"],
        categories: [.foods, .holidayHazards],
        imageAsset: "chocolate",
        description: "Chocolate is made from roasted cacao beans and is commonly found in candy, baked goods, beverages, and desserts. Cocoa bean hull mulch used in gardens also poses a risk.",
        toxicityInfo: "Chocolate contains theobromine and caffeine, both methylxanthines that dogs and cats cannot metabolize efficiently. Toxicity risk varies significantly by chocolate type — darker and more bitter chocolates are far more dangerous. In order of risk: cocoa powder and cacao beans are most dangerous, followed by unsweetened baking chocolate, semisweet chocolate, milk chocolate, and white chocolate (minimal risk). The high fat and sugar content in some chocolate products can also trigger pancreatitis.",
        onsetTime: OnsetTime(
            early: "Caffeine effects begin within 30-60 minutes. Theobromine effects may take 2+ hours to appear. Initial signs include vomiting, restlessness, bloating, and increased thirst.",
            delayed: "Theobromine is metabolized slowly (17.5-hour half-life in dogs). Effects can persist for several days. Signs may progress to cardiac arrhythmias, seizures, and other serious complications."
        ),
        symptoms: [
            "Vomiting",
            "Restlessness and hyperexcitability",
            "Bloating",
            "Increased thirst",
            "Rapid heart rate or abnormal heart rhythm",
            "Rapid breathing",
            "Elevated body temperature",
            "Muscle tremors or rigidity",
            "Seizures (severe cases)",
            "Very high doses: low blood pressure, slow heart rate, coma"
        ],
        speciesRisks: [
            SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are commonly affected due to indiscriminate eating habits. Hospitalization is often required for treatment."),
            SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are more sensitive to methylxanthines than dogs, though they rarely consume chocolate voluntarily.")
        ],
        preventionTips: [
            "Store all chocolate products in closed cabinets out of pet reach",
            "Be especially vigilant during holidays when chocolate is abundant",
            "Educate children not to share chocolate with pets",
            "Remember that baking chocolate and dark chocolate are most dangerous"
        ],
        sources: ["ASPCA Animal Poison Control Center", "Merck Veterinary Manual", "Veterinary Information Network (VIN)", "VCA Animal Hospitals"]
    )
}
