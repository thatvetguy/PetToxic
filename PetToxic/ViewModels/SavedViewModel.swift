import Foundation
import Combine

@MainActor
class SavedViewModel: ObservableObject {
    @Published var bookmarks: [ToxicItem] = []
    @Published var recentlyViewed: [ToxicItem] = []
    @Published var recentSearches: [String] = []

    private let bookmarkService = BookmarkService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadData()
        setupSubscriptions()
    }

    private func loadData() {
        bookmarks = bookmarkService.bookmarks
        recentlyViewed = bookmarkService.history
        recentSearches = UserDefaults.standard.stringArray(forKey: "recentSearches") ?? []
    }

    private func setupSubscriptions() {
        bookmarkService.$bookmarks
            .receive(on: RunLoop.main)
            .assign(to: &$bookmarks)

        bookmarkService.$history
            .receive(on: RunLoop.main)
            .assign(to: &$recentlyViewed)
    }

    func removeBookmarks(at offsets: IndexSet) {
        for index in offsets {
            let item = bookmarks[index]
            bookmarkService.removeBookmark(item)
        }
    }

    func clearHistory() {
        bookmarkService.clearHistory()
        UserDefaults.standard.removeObject(forKey: "recentSearches")
        recentSearches = []
    }
}
