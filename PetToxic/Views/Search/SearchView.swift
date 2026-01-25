import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                AppBackground()

                VStack(spacing: 0) {
                    // Custom header
                    HomeHeader()

                    // Main content area
                    ScrollView {
                        VStack(spacing: 20) {
                            // Content based on search state
                            if viewModel.searchText.isEmpty {
                                recentSearchesContent
                            } else if viewModel.isSearching {
                                ProgressView("Searching...")
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 40)
                            } else if viewModel.searchResults.isEmpty {
                                emptyResultsView
                            } else {
                                searchResultsContent
                            }

                            // My Pets section (always visible when not actively searching)
                            if viewModel.searchText.isEmpty {
                                MyPetsHomeSection()
                                    .padding(.top, 8)
                            }
                        }
                        .padding(.top, 8)
                    }

                    Spacer(minLength: 0)

                    // Ad banner at bottom
                    if viewModel.searchText.isEmpty {
                        AdBannerPlaceholder()
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .searchable(
                text: $viewModel.searchText,
                prompt: "Search foods, plants, medications..."
            )
            .onSubmit(of: .search) {
                viewModel.saveToRecentSearches(viewModel.searchText)
            }
            .onAppear {
                viewModel.reloadRecentSearches()
            }
            .navigationDestination(for: ToxicItem.self) { item in
                ArticleDetailView(item: item, saveSearchTerm: true)
            }
        }
    }

    private var recentSearchesContent: some View {
        Group {
            if viewModel.recentSearches.isEmpty {
                // Empty state
                VStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 40))
                        .foregroundColor(.white.opacity(0.4))

                    Text("No Recent Searches")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))

                    Text("Search for foods, plants, medications, and other substances to check their toxicity.")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .padding(.top, 32)
            } else {
                // Recent searches list
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Recent Searches")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                        Button("Clear") {
                            viewModel.clearAllRecentSearches()
                        }
                        .font(.subheadline)
                        .foregroundColor(Color(red: 0.29, green: 0.61, blue: 0.61))
                    }
                    .padding(.horizontal)

                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(viewModel.recentSearches.prefix(15), id: \.self) { search in
                                Button {
                                    viewModel.searchText = search
                                } label: {
                                    HStack {
                                        Image(systemName: "clock")
                                            .foregroundColor(.white.opacity(0.5))
                                        Text(search)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.3))
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 12)
                                }

                                if search != viewModel.recentSearches.prefix(15).last {
                                    Divider()
                                        .background(Color.white.opacity(0.1))
                                        .padding(.leading, 44)
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                }
            }
        }
    }

    private var emptyResultsView: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundColor(.white.opacity(0.4))

            Text("No Results")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))

            Text("No results found for \"\(viewModel.searchText)\". Try a different search term.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .padding(.top, 32)
    }

    private var searchResultsContent: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.searchResults) { result in
                NavigationLink(value: result.item) {
                    SearchResultRow(result: result)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.plain)

                if result.id != viewModel.searchResults.last?.id {
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.leading, 16)
                }
            }
        }
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
        .onChange(of: viewModel.searchText) { _, newValue in
            SearchContext.shared.pendingSearchTerm = newValue
        }
        .onAppear {
            SearchContext.shared.pendingSearchTerm = viewModel.searchText
        }
    }
}

#Preview {
    SearchView()
}
