import Foundation

class BookmarkService: ObservableObject {
    static let shared = BookmarkService()

    @Published var bookmarks: [ToxicItem] = []
    @Published var history: [ToxicItem] = []

    private let bookmarksKey = "bookmarkedItemIds"
    private let historyKey = "viewHistoryIds"
    private let maxHistoryItems = 50

    private init() {
        loadBookmarks()
        loadHistory()
    }

    // MARK: - Bookmarks

    func isBookmarked(_ item: ToxicItem) -> Bool {
        bookmarks.contains { $0.id == item.id }
    }

    func addBookmark(_ item: ToxicItem) {
        guard !isBookmarked(item) else { return }
        bookmarks.insert(item, at: 0)
        saveBookmarks()
    }

    func removeBookmark(_ item: ToxicItem) {
        bookmarks.removeAll { $0.id == item.id }
        saveBookmarks()
    }

    private func loadBookmarks() {
        guard let ids = UserDefaults.standard.array(forKey: bookmarksKey) as? [String] else { return }
        let uuids = ids.compactMap { UUID(uuidString: $0) }

        bookmarks = uuids.compactMap { id in
            DatabaseService.shared.item(withId: id)
        }
    }

    private func saveBookmarks() {
        let ids = bookmarks.map { $0.id.uuidString }
        UserDefaults.standard.set(ids, forKey: bookmarksKey)
    }

    // MARK: - History

    func addToHistory(_ item: ToxicItem) {
        history.removeAll { $0.id == item.id }
        history.insert(item, at: 0)

        if history.count > maxHistoryItems {
            history = Array(history.prefix(maxHistoryItems))
        }

        saveHistory()
    }

    func clearHistory() {
        history.removeAll()
        saveHistory()
    }

    private func loadHistory() {
        guard let ids = UserDefaults.standard.array(forKey: historyKey) as? [String] else { return }
        let uuids = ids.compactMap { UUID(uuidString: $0) }

        history = uuids.compactMap { id in
            DatabaseService.shared.item(withId: id)
        }
    }

    private func saveHistory() {
        let ids = history.map { $0.id.uuidString }
        UserDefaults.standard.set(ids, forKey: historyKey)
    }
}
