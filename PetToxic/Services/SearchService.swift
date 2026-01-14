import Foundation

class SearchService {
    private let databaseService = DatabaseService.shared

    func search(query: String, species: [Species]?) async throws -> [SearchResult] {
        // Simulate async search
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
