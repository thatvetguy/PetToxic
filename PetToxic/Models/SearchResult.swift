import Foundation

struct SearchResult: Identifiable {
    let id: UUID
    let item: ToxicItem
    let relevanceScore: Double
    let matchType: MatchType

    init(item: ToxicItem, relevanceScore: Double, matchType: MatchType) {
        self.id = item.id
        self.item = item
        self.relevanceScore = relevanceScore
        self.matchType = matchType
    }
}
