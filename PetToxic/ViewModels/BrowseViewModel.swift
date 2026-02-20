import Foundation

@MainActor
class BrowseViewModel: ObservableObject {
    @Published var itemsByCategory: [Category: [ToxicItem]] = [:]

    private let databaseService = DatabaseService.shared
    private(set) var allItems: [ToxicItem] = []

    init() {
        loadItems()
    }

    private func loadItems() {
        allItems = databaseService.allToxicItems()
        for category in Category.allCases {
            itemsByCategory[category] = databaseService.items(for: category)
        }
    }

    func itemCount(for category: Category) -> Int {
        // Exclude the severity explainer from category counts
        itemsByCategory[category]?.filter { $0.id != DatabaseService.severityExplainerId }.count ?? 0
    }

    func items(for category: Category) -> [ToxicItem] {
        itemsByCategory[category] ?? []
    }

    // MARK: - Severity Group Methods

    /// Returns items matching a severity group, excluding the explainer entry.
    func items(for severityGroup: SeverityGroupLevel) -> [ToxicItem] {
        allItems.filter { item in
            guard item.id != DatabaseService.severityExplainerId else { return false }
            return severityGroup.matches(entrySeverity: item.entrySeverity)
        }
    }

    /// Returns the count of items in a severity group (excludes explainer).
    func itemCount(for severityGroup: SeverityGroupLevel) -> Int {
        items(for: severityGroup).count
    }

    /// Returns the severity explainer entry, if it exists.
    var severityExplainerEntry: ToxicItem? {
        allItems.first { $0.id == DatabaseService.severityExplainerId }
    }
}
