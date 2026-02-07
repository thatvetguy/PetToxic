import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()
    @FocusState private var isSearchFocused: Bool
    @ObservedObject private var proSettings = ProSettings.shared

    private var isProUser: Bool { proSettings.isPro }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                AppBackground()

                VStack(spacing: 0) {
                    // Custom header
                    HomeHeader()

                    // Custom search bar
                    searchBar
                        .animation(.easeInOut(duration: 0.2), value: isSearchFocused)

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

                            // Pro features section (always visible when not actively searching)
                            if viewModel.searchText.isEmpty {
                                // My Pets section
                                MyPetsHomeSection()
                                    .padding(.top, 8)

                                // Lab Work Guide card
                                LabWorkGuideCard()
                                    .padding(.horizontal)
                                    .padding(.top, 8)

                                // Medical Glossary card
                                GlossaryCard()
                                    .padding(.horizontal)
                                    .padding(.top, 8)
                            }
                        }
                        .padding(.top, 8)
                        .padding(.bottom, isProUser ? 80 : 20)
                    }
                    .scrollDismissesKeyboard(.interactively)
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            isSearchFocused = false
                        }
                    )

                    Spacer(minLength: 0)

                    // Ad banner at bottom (only for free users)
                    if viewModel.searchText.isEmpty && !isProUser {
                        AdBannerPlaceholder()
                            .padding(.bottom, 80)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .onAppear {
                viewModel.reloadRecentSearches()
            }
            .navigationDestination(for: ToxicItem.self) { item in
                ArticleDetailView(item: item, saveSearchTerm: true, searchQuery: viewModel.searchText)
            }
        }
    }

    // MARK: - Custom Search Bar

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white.opacity(0.5))

            TextField("Search foods, plants, medications...", text: $viewModel.searchText)
                .foregroundColor(.white)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
                .focused($isSearchFocused)
                .onSubmit {
                    isSearchFocused = false
                    viewModel.saveToRecentSearches(viewModel.searchText)
                }

            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white.opacity(0.5))
                }
            }

            if isSearchFocused {
                Button("Cancel") {
                    isSearchFocused = false
                    viewModel.searchText = ""
                }
                .foregroundColor(AppColors.teal)
                .font(.subheadline)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }

    private var recentSearchesContent: some View {
        Group {
            if viewModel.recentSearches.isEmpty {
                // Empty state
                VStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
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
                        .foregroundColor(AppColors.teal)
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
                .font(.largeTitle)
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
