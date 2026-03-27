//
// extract_content.swift
//
// Compiles against PetToxic source files and extracts all hardcoded
// ToxicItem data into toxins.json and diseases.json.
//
// Usage (from project root):
//   swiftc -framework SwiftUI \
//     PetToxic/Models/Enums.swift \
//     PetToxic/Models/ToxicItem.swift \
//     PetToxic/Models/SpeciesRisk.swift \
//     PetToxic/Services/DatabaseService.swift \
//     PetToxic/Services/DiseasesConditionsService.swift \
//     Scripts/extract_content.swift \
//     -o Scripts/extract_content
//   ./Scripts/extract_content
//

import Foundation

// MARK: - JSON Schema Structs

/// Matches the toxins.json schema from ClaudeCode_Session164_AndroidJSONSchema.md
struct ToxinEntryJSON: Encodable {
    let id: String
    let name: String
    let alternateNames: [String]
    let categories: [String]
    let imageAsset: String?
    let description: String
    let toxicityInfo: String
    let onsetTime: OnsetTimeJSON?
    let symptoms: [String]
    let entrySeverity: String?
    let speciesRisks: [SpeciesRiskJSON]
    let preventionTips: [String]?
    let sources: [String]
    let relatedEntries: [String]?
}

/// Matches the diseases.json schema from ClaudeCode_Session164_AndroidJSONSchema.md
struct DiseaseEntryJSON: Encodable {
    let id: String
    let name: String
    let entryType: String
    let alternateNames: [String]
    let imageAsset: String?
    let description: String
    let toxicityInfo: String
    let onsetTime: OnsetTimeJSON?
    let symptoms: [String]
    let speciesRisks: [SpeciesRiskJSON]
    let preventionTips: [String]?
    let sources: [String]
    let relatedEntries: [String]?
}

struct OnsetTimeJSON: Encodable {
    let early: String?
    let delayed: String?
}

struct SpeciesRiskJSON: Encodable {
    let species: String
    let severity: String
    let notes: String?
}

struct ToxinsFile: Encodable {
    let version: Int
    let entries: [ToxinEntryJSON]
}

struct DiseasesFile: Encodable {
    let version: Int
    let entries: [DiseaseEntryJSON]
}

// MARK: - Conversion Helpers

func convertOnsetTime(_ onset: OnsetTime?) -> OnsetTimeJSON? {
    guard let onset = onset else { return nil }
    return OnsetTimeJSON(early: onset.early, delayed: onset.delayed)
}

func convertSpeciesRisks(_ risks: [SpeciesRisk]) -> [SpeciesRiskJSON] {
    risks.map { risk in
        SpeciesRiskJSON(
            species: risk.species.rawValue,
            severity: risk.severity.rawValue,
            notes: risk.notes
        )
    }
}

func convertToToxinEntry(_ item: ToxicItem) -> ToxinEntryJSON {
    ToxinEntryJSON(
        id: item.id.uuidString,
        name: item.name,
        alternateNames: item.alternateNames,
        categories: item.categories.map { $0.rawValue },
        imageAsset: item.imageAsset,
        description: item.description,
        toxicityInfo: item.toxicityInfo,
        onsetTime: convertOnsetTime(item.onsetTime),
        symptoms: item.symptoms,
        entrySeverity: item.entrySeverity?.rawValue,
        speciesRisks: convertSpeciesRisks(item.speciesRisks),
        preventionTips: item.preventionTips,
        sources: item.sources,
        relatedEntries: item.relatedEntries
    )
}

func convertToDiseaseEntry(_ item: ToxicItem, entryType: String) -> DiseaseEntryJSON {
    DiseaseEntryJSON(
        id: item.id.uuidString,
        name: item.name,
        entryType: entryType,
        alternateNames: item.alternateNames,
        imageAsset: item.imageAsset,
        description: item.description,
        toxicityInfo: item.toxicityInfo,
        onsetTime: convertOnsetTime(item.onsetTime),
        symptoms: item.symptoms,
        speciesRisks: convertSpeciesRisks(item.speciesRisks),
        preventionTips: item.preventionTips,
        sources: item.sources,
        relatedEntries: item.relatedEntries
    )
}

func determineEntryType(_ item: ToxicItem, service: DiseasesConditionsService) -> String {
    if service.isHusbandry(item) {
        return "husbandry"
    } else if !service.isInfectious(item) {
        return "medical"
    } else {
        return "infectious"
    }
}

// MARK: - Main Extraction

@main
struct ExtractContent {
static func main() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

    // Resolve output directory
    let scriptPath = CommandLine.arguments[0]
    let projectRoot: String
    if scriptPath.contains("Scripts/") {
        projectRoot = String(scriptPath.prefix(upTo: scriptPath.range(of: "Scripts/")!.lowerBound))
    } else {
        projectRoot = FileManager.default.currentDirectoryPath + "/"
    }
    let contentDir = projectRoot + "Content/"

    // Create Content directory if needed
    try? FileManager.default.createDirectory(
        atPath: contentDir,
        withIntermediateDirectories: true
    )

    // --- Extract toxins ---
    let dbService = DatabaseService.shared
    let allToxins = dbService.allToxicItems()
    let toxinEntries = allToxins.map { convertToToxinEntry($0) }
    let toxinsFile = ToxinsFile(version: 1, entries: toxinEntries)

    do {
        let toxinsData = try encoder.encode(toxinsFile)
        let toxinsPath = contentDir + "toxins.json"
        try toxinsData.write(to: URL(fileURLWithPath: toxinsPath))
        print("✅ toxins.json: \(toxinEntries.count) entries → \(toxinsPath)")
    } catch {
        print("❌ Failed to write toxins.json: \(error)")
        exit(1)
    }

    // --- Extract diseases ---
    let dcService = DiseasesConditionsService.shared
    let allDiseases = dcService.entries
    let diseaseEntries = allDiseases.map { item in
        convertToDiseaseEntry(item, entryType: determineEntryType(item, service: dcService))
    }
    let diseasesFile = DiseasesFile(version: 1, entries: diseaseEntries)

    do {
        let diseasesData = try encoder.encode(diseasesFile)
        let diseasesPath = contentDir + "diseases.json"
        try diseasesData.write(to: URL(fileURLWithPath: diseasesPath))
        print("✅ diseases.json: \(diseaseEntries.count) entries → \(diseasesPath)")
    } catch {
        print("❌ Failed to write diseases.json: \(error)")
        exit(1)
    }

    // --- Validation summary ---
    print("\n📊 Validation Summary:")
    print("   Toxin entries: \(toxinEntries.count)")
    print("   Disease entries: \(diseaseEntries.count)")
    print("   Total: \(toxinEntries.count + diseaseEntries.count)")

    // Validate all UUIDs are unique
    let allIDs = toxinEntries.map { $0.id } + diseaseEntries.map { $0.id }
    let uniqueIDs = Set(allIDs)
    if allIDs.count != uniqueIDs.count {
        print("   ⚠️  WARNING: \(allIDs.count - uniqueIDs.count) duplicate UUID(s) found!")
    } else {
        print("   ✅ All UUIDs unique")
    }

    // Validate cross-references
    var unresolvedRefs = 0
    for entry in toxinEntries {
        if let refs = entry.relatedEntries {
            for ref in refs {
                if !uniqueIDs.contains(ref) {
                    print("   ⚠️  Unresolved ref in '\(entry.name)': \(ref)")
                    unresolvedRefs += 1
                }
            }
        }
    }
    for entry in diseaseEntries {
        if let refs = entry.relatedEntries {
            for ref in refs {
                if !uniqueIDs.contains(ref) {
                    print("   ⚠️  Unresolved ref in '\(entry.name)': \(ref)")
                    unresolvedRefs += 1
                }
            }
        }
    }
    if unresolvedRefs == 0 {
        print("   ✅ All cross-references resolve")
    } else {
        print("   ⚠️  \(unresolvedRefs) unresolved cross-reference(s)")
    }

    // Disease entry type breakdown
    let infectious = diseaseEntries.filter { $0.entryType == "infectious" }.count
    let husbandry = diseaseEntries.filter { $0.entryType == "husbandry" }.count
    let medical = diseaseEntries.filter { $0.entryType == "medical" }.count
    print("   Disease types: \(infectious) infectious, \(husbandry) husbandry, \(medical) medical")

    // Category breakdown for toxins
    var categoryCounts: [String: Int] = [:]
    for entry in toxinEntries {
        for cat in entry.categories {
            categoryCounts[cat, default: 0] += 1
        }
    }
    print("   Toxin categories:")
    for (cat, count) in categoryCounts.sorted(by: { $0.key < $1.key }) {
        print("     \(cat): \(count)")
    }

    print("\n✅ Extraction complete!")
}
}
