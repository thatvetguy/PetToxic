import Foundation

@MainActor
class ArticleViewModel: ObservableObject {
    private let bookmarkService = BookmarkService.shared

    func isBookmarked(_ item: ToxicItem) -> Bool {
        bookmarkService.isBookmarked(item)
    }

    func toggleBookmark(for item: ToxicItem) {
        if bookmarkService.isBookmarked(item) {
            bookmarkService.removeBookmark(item)
        } else {
            bookmarkService.addBookmark(item)
        }
    }

    func recordView(of item: ToxicItem) {
        bookmarkService.addToHistory(item)
    }
}
