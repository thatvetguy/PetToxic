import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedSpecies: Set<Species> = []
    @Published var searchResults: [SearchResult] = []
    @Published var isSearching = false
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
            return
        }

        isSearching = true

        do {
            let results = try await searchService.search(
                query: query,
                species: selectedSpecies.isEmpty ? nil : Array(selectedSpecies)
            )
            searchResults = results
            addRecentSearch(query)
        } catch {
            searchResults = []
        }

        isSearching = false
    }

    private func loadRecentSearches() {
        recentSearches = UserDefaults.standard.stringArray(forKey: "recentSearches") ?? []
    }

    private func addRecentSearch(_ query: String) {
        var searches = recentSearches
        searches.removeAll { $0.lowercased() == query.lowercased() }
        searches.insert(query, at: 0)
        searches = Array(searches.prefix(10))
        recentSearches = searches
        UserDefaults.standard.set(searches, forKey: "recentSearches")
    }

    func removeRecentSearch(at offsets: IndexSet) {
        recentSearches.remove(atOffsets: offsets)
        UserDefaults.standard.set(recentSearches, forKey: "recentSearches")
    }
}
