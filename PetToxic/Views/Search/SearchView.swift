import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
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
            .onSubmit(of: .search) {
                // Save to recent searches when user presses Return/Search
                viewModel.saveToRecentSearches(viewModel.searchText)
            }
            .onAppear {
                // Reload recent searches in case they were added from detail view
                viewModel.reloadRecentSearches()
            }
            .navigationDestination(for: ToxicItem.self) { item in
                ArticleDetailView(item: item, saveSearchTerm: true)
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
                    Section {
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
                    } header: {
                        HStack {
                            Text("Recent Searches")
                            Spacer()
                            Button("Clear") {
                                viewModel.clearAllRecentSearches()
                            }
                            .font(.subheadline)
                            .textCase(nil)
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
        .onChange(of: viewModel.searchText) { newValue in
            // Keep the pending search term updated so it can be saved when navigating to detail
            SearchContext.shared.pendingSearchTerm = newValue
        }
        .onAppear {
            // Set initial pending term when results appear
            SearchContext.shared.pendingSearchTerm = viewModel.searchText
        }
    }
}

#Preview {
    SearchView()
}
