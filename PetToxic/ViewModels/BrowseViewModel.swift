import Foundation

@MainActor
class BrowseViewModel: ObservableObject {
    @Published var itemsByCategory: [Category: [ToxicItem]] = [:]

    private let databaseService = DatabaseService.shared

    init() {
        loadItems()
    }

    private func loadItems() {
        for category in Category.allCases {
            itemsByCategory[category] = databaseService.items(for: category)
        }
    }

    func itemCount(for category: Category) -> Int {
        itemsByCategory[category]?.count ?? 0
    }

    func items(for category: Category) -> [ToxicItem] {
        itemsByCategory[category] ?? []
    }
}
