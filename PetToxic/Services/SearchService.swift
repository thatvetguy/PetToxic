import Foundation

class SearchService {
    private let databaseService = DatabaseService.shared

    /// Maps severity search terms to their corresponding group levels.
    private static let severityTermMap: [String: SeverityGroupLevel] = [
        "severe": .severe,
        "high": .high,
        "moderate": .moderate,
        "low": .low,
        "informational": .informational
    ]

    func search(query: String, species: [Species]?) async -> [SearchResult] {
        let trimmed = query.trimmingCharacters(in: .whitespaces).lowercased()

        // Check for severity term search
        if let severityGroup = SearchService.severityTermMap[trimmed] {
            return severitySearchResults(for: severityGroup, species: species)
        }

        // Normal search
        let items = databaseService.search(query: query, species: species)

        return items.enumerated().map { index, item in
            let matchType = determineMatchType(query: query, item: item)
            let relevanceScore = calculateRelevance(query: query, item: item, position: index)

            return SearchResult(
                item: item,
                relevanceScore: relevanceScore,
                matchType: matchType
            )
        }
        .sorted { $0.relevanceScore > $1.relevanceScore }
    }

    /// Returns all entries matching a severity group, sorted alphabetically.
    private func severitySearchResults(for group: SeverityGroupLevel, species: [Species]?) -> [SearchResult] {
        var items = databaseService.allToxicItems().filter { item in
            guard item.id != DatabaseService.severityExplainerId else { return false }
            return group.matches(entrySeverity: item.entrySeverity)
        }

        if let species = species, !species.isEmpty {
            items = items.filter { item in
                item.speciesRisks.contains { species.contains($0.species) }
            }
        }

        return items
            .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
            .enumerated()
            .map { index, item in
                SearchResult(
                    item: item,
                    relevanceScore: 100.0 - Double(index),
                    matchType: .exact
                )
            }
    }

    private func determineMatchType(query: String, item: ToxicItem) -> MatchType {
        let lowercasedQuery = query.lowercased()

        if item.name.lowercased() == lowercasedQuery {
            return .exact
        } else if item.name.lowercased().hasPrefix(lowercasedQuery) {
            return .prefix
        } else if item.alternateNames.contains(where: { $0.lowercased() == lowercasedQuery }) {
            return .synonym
        } else {
            return .fuzzy
        }
    }

    private func calculateRelevance(query: String, item: ToxicItem, position: Int) -> Double {
        var score = 100.0 - Double(position)

        let lowercasedQuery = query.lowercased()

        // Exact match bonus
        if item.name.lowercased() == lowercasedQuery {
            score += 50
        }

        // Prefix match bonus
        if item.name.lowercased().hasPrefix(lowercasedQuery) {
            score += 25
        }

        // Alternate name match bonus
        if item.alternateNames.contains(where: { $0.lowercased().contains(lowercasedQuery) }) {
            score += 10
        }

        return score
    }
}
