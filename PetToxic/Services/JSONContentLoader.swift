import Foundation

// MARK: - Loaded Content

/// The decoded content bundle: everything the app knows about toxins and
/// diseases, sourced from Content/toxins.json + Content/diseases.json.
struct LoadedContent {
    let toxins: [ToxicItem]
    let diseases: [ToxicItem]
    /// Per-entry classification from diseases.json `entryType`.
    let diseaseEntryTypes: [UUID: DiseaseEntryType]
}

enum ContentLoadError: Error, CustomStringConvertible {
    case missingResource(String)
    case decodeFailure(String, Error)
    case unsupportedVersion(String, Int)
    case emptyContent(String)

    var description: String {
        switch self {
        case .missingResource(let name):
            return "Bundled content file '\(name)' not found — check Copy Bundle Resources."
        case .decodeFailure(let name, let error):
            return "Failed to decode '\(name)': \(error)"
        case .unsupportedVersion(let name, let version):
            return "'\(name)' has schema version \(version); this build supports version \(JSONContentLoader.supportedSchemaVersion)."
        case .emptyContent(let name):
            return "'\(name)' decoded to zero entries — refusing to run with empty content."
        }
    }
}

// MARK: - Loader

/// Decodes the JSON content files (the single source of truth — see
/// Documentation/JSON_SourceOfTruth_MigrationPlan.md). The URL-based entry
/// point keeps the content source injectable: the parity/CI harness loads
/// from the repo, and a future content-OTA layer could swap in a downloaded
/// copy without touching the decode path.
enum JSONContentLoader {

    /// The schema version this build understands (root `version` field in
    /// both content files — see ClaudeCode_Session164_AndroidJSONSchema.md).
    static let supportedSchemaVersion = 1

    private struct ContentFile<Entry: Decodable>: Decodable {
        let version: Int
        let entries: [Entry]
    }

    /// Rejects unsupported schema versions and empty entry arrays — both
    /// must fail loudly rather than produce a hollow "working" app.
    private static func vet<E>(_ file: ContentFile<E>, name: String) throws {
        guard file.version == supportedSchemaVersion else {
            throw ContentLoadError.unsupportedVersion(name, file.version)
        }
        guard !file.entries.isEmpty else {
            throw ContentLoadError.emptyContent(name)
        }
    }

    /// Decodes the diseases.json entry shape, which differs from ToxicItem:
    /// `categories` is omitted (implicitly Diseases & Conditions),
    /// `entrySeverity` is omitted (implicitly nil = no severity badge), and
    /// `entryType` is added (drives classification + section title).
    struct DiseaseEntryDTO: Decodable {
        let id: UUID
        let name: String
        let entryType: DiseaseEntryType
        let alternateNames: [String]
        let imageAsset: String?
        let description: String
        let toxicityInfo: String
        let onsetTime: OnsetTime?
        let symptoms: [String]
        let speciesRisks: [SpeciesRisk]
        let preventionTips: [String]?
        let sources: [String]
        let relatedEntries: [String]?

        func toToxicItem() -> ToxicItem {
            ToxicItem(
                id: id,
                name: name,
                alternateNames: alternateNames,
                categories: [.diseasesAndConditions],
                imageAsset: imageAsset,
                description: description,
                toxicityInfo: toxicityInfo,
                toxicityInfoSectionTitle: entryType.toxicityInfoSectionTitle,
                onsetTime: onsetTime,
                symptoms: symptoms,
                entrySeverity: nil,
                speciesRisks: speciesRisks,
                preventionTips: preventionTips,
                sources: sources,
                relatedEntries: relatedEntries
            )
        }
    }

    /// Pure decode from explicit file URLs. Throws on any structural problem;
    /// callers decide the failure policy.
    static func load(toxinsURL: URL, diseasesURL: URL) throws -> LoadedContent {
        let decoder = JSONDecoder()

        let toxinsFile: ContentFile<ToxicItem>
        do {
            toxinsFile = try decoder.decode(ContentFile<ToxicItem>.self,
                                            from: Data(contentsOf: toxinsURL))
        } catch {
            throw ContentLoadError.decodeFailure("toxins.json", error)
        }

        let diseasesFile: ContentFile<DiseaseEntryDTO>
        do {
            diseasesFile = try decoder.decode(ContentFile<DiseaseEntryDTO>.self,
                                              from: Data(contentsOf: diseasesURL))
        } catch {
            throw ContentLoadError.decodeFailure("diseases.json", error)
        }

        try vet(toxinsFile, name: "toxins.json")
        try vet(diseasesFile, name: "diseases.json")

        return LoadedContent(
            toxins: toxinsFile.entries,
            diseases: diseasesFile.entries.map { $0.toToxicItem() },
            diseaseEntryTypes: Dictionary(uniqueKeysWithValues:
                diseasesFile.entries.map { ($0.id, $0.entryType) })
        )
    }

    /// Bundled content, loaded once with the Phase A failure policy:
    /// DEBUG builds crash immediately (a decode failure is an unshippable
    /// build — the content is validated by pre-commit + CI before it can
    /// reach the bundle). RELEASE builds fail closed: `bundled` is nil and
    /// the app shows a blocking "content unavailable" screen rather than a
    /// silently partial emergency reference.
    static let bundled: LoadedContent? = {
        do {
            guard let toxinsURL = Bundle.main.url(forResource: "toxins", withExtension: "json") else {
                throw ContentLoadError.missingResource("toxins.json")
            }
            guard let diseasesURL = Bundle.main.url(forResource: "diseases", withExtension: "json") else {
                throw ContentLoadError.missingResource("diseases.json")
            }
            // load() itself rejects unsupported versions and empty entries,
            // so a non-nil return here is guaranteed non-hollow in RELEASE too.
            return try load(toxinsURL: toxinsURL, diseasesURL: diseasesURL)
        } catch {
            #if DEBUG
            fatalError("Content load failed: \(error)")
            #else
            return nil
            #endif
        }
    }()
}
