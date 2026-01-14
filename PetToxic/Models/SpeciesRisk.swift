import Foundation

struct SpeciesRisk: Codable, Hashable, Identifiable {
    let species: Species
    let severity: Severity
    let notes: String?

    var id: String { species.rawValue }
}
