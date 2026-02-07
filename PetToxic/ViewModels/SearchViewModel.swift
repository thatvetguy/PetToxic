import Foundation
import Combine

/// Shared context for passing search term to detail views
@MainActor
class SearchContext: ObservableObject {
    static let shared = SearchContext()
    @Published var pendingSearchTerm: String?

    private init() {}

    func saveIfPending() {
        guard let term = pendingSearchTerm else { return }
        let trimmed = term.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            pendingSearchTerm = nil
            return
        }

        var searches = UserDefaults.standard.stringArray(forKey: "recentSearches") ?? []
        searches.removeAll { $0.lowercased() == trimmed.lowercased() }
        searches.insert(trimmed, at: 0)
        searches = Array(searches.prefix(10))
        UserDefaults.standard.set(searches, forKey: "recentSearches")

        pendingSearchTerm = nil
    }
}

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedSpecies: Set<Species> = []
    @Published var searchResults: [SearchResult] = []
    @Published var isSearching = false
    @Published var searchError = false
    @Published var recentSearches: [String] = []

    private let searchService = SearchService()
    private let bookmarkService = BookmarkService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadRecentSearches()
        setupSearchSubscription()
    }

    private func setupSearchSubscription() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                Task {
                    await self?.performSearch(query: query)
                }
            }
            .store(in: &cancellables)

        $selectedSpecies
            .sink { [weak self] _ in
                guard let self = self, !self.searchText.isEmpty else { return }
                Task {
                    await self.performSearch(query: self.searchText)
                }
            }
            .store(in: &cancellables)
    }

    private func performSearch(query: String) async {
        guard !query.isEmpty else {
            searchResults = []
            searchError = false
            return
        }

        isSearching = true
        searchError = false

        let results = await searchService.search(
            query: query,
            species: selectedSpecies.isEmpty ? nil : Array(selectedSpecies)
        )
        searchResults = results

        isSearching = false
    }

    private func loadRecentSearches() {
        recentSearches = UserDefaults.standard.stringArray(forKey: "recentSearches") ?? []
    }

    /// Reload recent searches from storage (call when view appears to pick up changes)
    func reloadRecentSearches() {
        loadRecentSearches()
    }

    /// Save a search term to recent searches. Call this only on explicit user actions:
    /// - When user taps on a search result
    /// - When user presses Return/Submit on the keyboard
    func saveToRecentSearches(_ query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        var searches = recentSearches
        // Remove duplicate (case-insensitive) to avoid spam
        searches.removeAll { $0.lowercased() == trimmed.lowercased() }
        // Add to beginning (most recent first)
        searches.insert(trimmed, at: 0)
        // Limit to 10 most recent
        searches = Array(searches.prefix(10))
        recentSearches = searches
        UserDefaults.standard.set(searches, forKey: "recentSearches")
    }

    func removeRecentSearch(at offsets: IndexSet) {
        recentSearches.remove(atOffsets: offsets)
        UserDefaults.standard.set(recentSearches, forKey: "recentSearches")
    }

    func clearAllRecentSearches() {
        recentSearches.removeAll()
        UserDefaults.standard.set(recentSearches, forKey: "recentSearches")
    }
}
