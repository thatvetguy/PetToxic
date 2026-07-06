// Phase A parity harness — proves JSONContentLoader output is identical to the
// hardcoded Swift content BEFORE the services are swapped to JSON.
// (Spec: Documentation/JSON_SourceOfTruth_MigrationPlan.md, validation gates.)
//
// Build & run from the repo root:
//   swiftc -framework SwiftUI \
//     PetToxic/Models/Enums.swift \
//     PetToxic/Models/ToxicItem.swift \
//     PetToxic/Models/SpeciesRisk.swift \
//     PetToxic/Services/DatabaseService.swift \
//     PetToxic/Services/DiseasesConditionsService.swift \
//     PetToxic/Services/JSONContentLoader.swift \
//     Scripts/parity_check.swift \
//     -o Scripts/parity_check
//   ./Scripts/parity_check
//
// Exit 0 = full parity. Exit 1 = any mismatch (do NOT proceed with cutover).
// Delete this script together with the hardcoded content at cutover — it has
// no meaning once the Swift arrays are gone.

import Foundation

var failures: [String] = []

func check(_ condition: Bool, _ message: String) {
    if !condition { failures.append(message) }
}

func fieldDiffs(_ a: ToxicItem, _ b: ToxicItem) -> [String] {
    var d: [String] = []
    if a.id != b.id { d.append("id") }
    if a.name != b.name { d.append("name") }
    if a.alternateNames != b.alternateNames { d.append("alternateNames") }
    if a.categories != b.categories { d.append("categories") }
    if a.imageAsset != b.imageAsset { d.append("imageAsset") }
    if a.description != b.description { d.append("description") }
    if a.toxicityInfo != b.toxicityInfo { d.append("toxicityInfo") }
    if a.toxicityInfoSectionTitle != b.toxicityInfoSectionTitle { d.append("toxicityInfoSectionTitle") }
    if a.onsetTime != b.onsetTime { d.append("onsetTime") }
    if a.symptoms != b.symptoms { d.append("symptoms") }
    if a.entrySeverity != b.entrySeverity { d.append("entrySeverity") }
    if a.speciesRisks != b.speciesRisks { d.append("speciesRisks") }
    if a.preventionTips != b.preventionTips { d.append("preventionTips") }
    if a.sources != b.sources { d.append("sources") }
    if a.relatedEntries != b.relatedEntries { d.append("relatedEntries") }
    return d
}

func comparePairwise(_ legacy: [ToxicItem], _ loaded: [ToxicItem], label: String) {
    check(legacy.count == loaded.count,
          "\(label): count mismatch — legacy \(legacy.count) vs loaded \(loaded.count)")
    check(legacy.map(\.id) == loaded.map(\.id),
          "\(label): ID ORDER differs (UI list order would change)")
    check(Set(legacy.map(\.id)) == Set(loaded.map(\.id)),
          "\(label): ID SETS differ")
    let loadedByID = Dictionary(uniqueKeysWithValues: loaded.map { ($0.id, $0) })
    for item in legacy {
        guard let counterpart = loadedByID[item.id] else {
            failures.append("\(label): '\(item.name)' missing from loaded content")
            continue
        }
        let diffs = fieldDiffs(item, counterpart)
        check(diffs.isEmpty, "\(label): '\(item.name)' field mismatch: \(diffs)")
    }
}

// MARK: - Entry point

@main
struct ParityCheck {
    static func main() {
        let cwd = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let content: LoadedContent
        do {
            content = try JSONContentLoader.load(
                toxinsURL: cwd.appendingPathComponent("Content/toxins.json"),
                diseasesURL: cwd.appendingPathComponent("Content/diseases.json")
            )
        } catch {
            print("❌ PARITY FAIL: could not load JSON content: \(error)")
            exit(1)
        }

        let legacyToxins = DatabaseService.shared.allToxicItems()
        let dcService = DiseasesConditionsService.shared
        let legacyDiseases = dcService.entries

        // MARK: Gates

        comparePairwise(legacyToxins, content.toxins, label: "toxins")
        comparePairwise(legacyDiseases, content.diseases, label: "diseases")

        check(legacyToxins.count == 198, "expected 198 toxin entries, legacy has \(legacyToxins.count)")
        check(legacyDiseases.count == 49, "expected 49 disease entries, legacy has \(legacyDiseases.count)")

        // entryType classification must reproduce the legacy UUID-set behavior
        var typeCounts: [DiseaseEntryType: Int] = [:]
        for item in legacyDiseases {
            let legacyType: DiseaseEntryType =
                dcService.isHusbandry(item) ? .husbandry :
                (dcService.isInfectious(item) ? .infectious : .medical)
            let loadedType = content.diseaseEntryTypes[item.id]
            check(loadedType == legacyType,
                  "entryType mismatch for '\(item.name)': legacy \(legacyType) vs JSON \(String(describing: loadedType))")
            typeCounts[legacyType, default: 0] += 1
        }
        check(typeCounts[.infectious] == 39 && typeCounts[.medical] == 7 && typeCounts[.husbandry] == 3,
              "entryType counts expected 39/7/3, got \(typeCounts)")

        // Derived section titles must reproduce the stored titles exactly
        for item in legacyDiseases {
            let derived = content.diseaseEntryTypes[item.id]?.toxicityInfoSectionTitle
            check(derived == item.toxicityInfoSectionTitle,
                  "title mismatch for '\(item.name)': stored '\(item.toxicityInfoSectionTitle ?? "nil")' vs derived '\(derived ?? "nil")'")
        }

        // MARK: Verdict

        if failures.isEmpty {
            print("✅ PARITY OK: \(legacyToxins.count) toxins + \(legacyDiseases.count) diseases identical across all fields; entryType 39/7/3; titles reproduce exactly.")
            exit(0)
        } else {
            print("❌ PARITY FAIL — \(failures.count) issue(s):")
            for f in failures.prefix(40) { print("  • \(f)") }
            exit(1)
        }
    }
}
