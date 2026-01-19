import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Species filter
                SpeciesFilterView(selectedSpecies: $viewModel.selectedSpecies)
                    .padding(.horizontal)
                    .padding(.vertical, 8)

                // Content
                if viewModel.searchText.isEmpty {
                    recentSearchesView
                } else if viewModel.isSearching {
                    ProgressView("Searching...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.searchResults.isEmpty {
                    emptyResultsView
                } else {
                    searchResultsList
                }
            }
            .navigationTitle("Search")
            .searchable(
                text: $viewModel.searchText,
                prompt: "Search foods, plants, medications..."
            )
            .navigationDestination(for: ToxicItem.self) { item in
                ArticleDetailView(item: item)
            }
        }
    }

    private var recentSearchesView: some View {
        VStack {
            if viewModel.recentSearches.isEmpty {
                EmptyStateView(
                    "Start Searching",
                    systemImage: "magnifyingglass",
                    description: "Search for foods, plants, medications, and other substances to check their toxicity."
                )
            } else {
                List {
                    Section("Recent Searches") {
                        ForEach(viewModel.recentSearches, id: \.self) { search in
                            Button {
                                viewModel.searchText = search
                            } label: {
                                Label(search, systemImage: "clock")
                            }
                            .foregroundStyle(.primary)
                        }
                        .onDelete { indexSet in
                            viewModel.removeRecentSearch(at: indexSet)
                        }
                    }
                }
            }
        }
    }

    private var emptyResultsView: some View {
        EmptyStateView(
            "No Results",
            systemImage: "magnifyingglass",
            description: "No results found for \"\(viewModel.searchText)\". Try a different search term."
        )
    }

    private var searchResultsList: some View {
        List(viewModel.searchResults) { result in
            NavigationLink(value: result.item) {
                SearchResultRow(result: result)
            }
        }
    }
}

#Preview {
    SearchView()
}
