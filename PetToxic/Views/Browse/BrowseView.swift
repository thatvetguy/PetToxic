import SwiftUI
import SwiftData

struct BrowseView: View {
    /// Navigation path binding - controlled by MainTabView for contextual swipe navigation
    @Binding var navigationPath: NavigationPath

    @StateObject private var viewModel = BrowseViewModel()
    @StateObject private var searchViewModel = SearchViewModel()
    @FocusState private var isSearchFocused: Bool
    @ObservedObject private var proSettings = ProSettings.shared
    @Environment(BrowseNavigationContext.self) private var navContext

    private var isProUser: Bool { proSettings.isPro }

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                AppBackground()

                VStack(spacing: 0) {
                    // Search bar
                    browseSearchBar
                        .animation(.easeInOut(duration: 0.2), value: isSearchFocused)

                    ScrollView {
                        if !searchViewModel.searchText.isEmpty {
                            // Search results
                            if searchViewModel.isSearching {
                                ProgressView("Searching...")
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 40)
                            } else if searchViewModel.searchResults.isEmpty {
                                browseEmptyResults
                            } else {
                                browseSearchResults
                            }
                        } else {
                            // Normal category grid
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(Category.allCases) { category in
                                    NavigationLink(value: category) {
                                        CategoryGridItem(
                                            category: category,
                                            itemCount: viewModel.itemCount(for: category)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding()
                            .padding(.bottom, 16)
                        }
                    }
                    .scrollDismissesKeyboard(.interactively)

                    Spacer(minLength: 0)

                    if searchViewModel.searchText.isEmpty {
                        if isProUser {
                            GlossaryCard()
                                .padding(.horizontal)
                                .padding(.bottom, 80)
                        } else {
                            AdBannerPlaceholder()
                                .padding(.bottom, 80)
                        }
                    }
                }
            }
            .navigationTitle("Pick your poison...")
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: Category.self) { category in
                CategoryListView(category: category)
            }
            .navigationDestination(for: ToxicItem.self) { item in
                ArticleDetailView(item: item, saveSearchTerm: true, searchQuery: searchViewModel.searchText)
            }
            .onChange(of: navigationPath.count) { oldCount, newCount in
                if newCount == 0 {
                    if navContext.isProgrammaticNavigation {
                        // Transient count=0 during swipe path replacement — ignore
                        navContext.isProgrammaticNavigation = false
                    } else {
                        navContext.returnToGrid()
                    }
                } else if navContext.isProgrammaticNavigation {
                    // Path settled to non-zero count, clear the flag
                    navContext.isProgrammaticNavigation = false
                }
            }
        }
    }

    // MARK: - Browse Search Bar

    private var browseSearchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white.opacity(0.5))

            TextField("Search foods, plants, medications...", text: $searchViewModel.searchText)
                .foregroundColor(.white)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
                .focused($isSearchFocused)
                .onSubmit {
                    isSearchFocused = false
                    searchViewModel.saveToRecentSearches(searchViewModel.searchText)
                }

            if !searchViewModel.searchText.isEmpty {
                Button {
                    searchViewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white.opacity(0.5))
                }
            }

            if isSearchFocused {
                Button("Cancel") {
                    isSearchFocused = false
                    searchViewModel.searchText = ""
                }
                .foregroundColor(Color(red: 0.29, green: 0.61, blue: 0.61))
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

    // MARK: - Browse Search Results

    private var browseSearchResults: some View {
        VStack(spacing: 0) {
            ForEach(searchViewModel.searchResults) { result in
                NavigationLink(value: result.item) {
                    SearchResultRow(result: result)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.plain)

                if result.id != searchViewModel.searchResults.last?.id {
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.leading, 16)
                }
            }
        }
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
        .onChange(of: searchViewModel.searchText) { _, newValue in
            SearchContext.shared.pendingSearchTerm = newValue
        }
    }

    private var browseEmptyResults: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundColor(.white.opacity(0.4))

            Text("No Results")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))

            Text("No results found for \"\(searchViewModel.searchText)\". Try a different search term.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .padding(.top, 32)
    }
}

// MARK: - Species Filter

enum SpeciesFilter: Equatable {
    case auto
    case all
    case specific(Species)
    case informational
}

struct CategoryListView: View {
    let category: Category
    @StateObject private var viewModel = BrowseViewModel()
    @Query private var pets: [Pet]
    @AppStorage("gridColumnCount") private var columnCount: Int = 2
    @AppStorage("entrySortBySeverity") private var sortBySeverity: Bool = true
    @AppStorage("entryViewMode") private var isGridView: Bool = true
    @State private var selectedSpeciesFilter: SpeciesFilter = .auto
    @Environment(BrowseNavigationContext.self) private var navContext

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 8), count: columnCount)
    }

    private var isInformationalCategory: Bool {
        category == .informational
    }

    private var autoFilterSpecies: Set<Species>? {
        BrowseFilterService.getDefaultSpeciesFilter(pets: pets)
    }

    private var filteredItems: [ToxicItem] {
        let items = viewModel.items(for: category)

        // Apply species filter
        let speciesFiltered: [ToxicItem]

        switch selectedSpeciesFilter {
        case .auto:
            speciesFiltered = items.filter {
                BrowseFilterService.entryMatchesFilter(entry: $0, speciesFilter: autoFilterSpecies)
            }
        case .all:
            speciesFiltered = items
        case .specific(let species):
            speciesFiltered = items.filter {
                BrowseFilterService.entryMatchesFilter(entry: $0, speciesFilter: [species])
            }
        case .informational:
            speciesFiltered = items.filter { $0.speciesRisks.isEmpty }
        }

        // Informational category always sorts alphabetically
        if isInformationalCategory || !sortBySeverity {
            return speciesFiltered.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        }

        // Determine species-specific sort when a single species is selected
        let sortSpecies: Species? = {
            if case .specific(let species) = selectedSpeciesFilter { return species }
            return nil
        }()

        // Sort by severity (highest first), with alphabetical tiebreaker
        return speciesFiltered.sorted {
            let s0 = severitySortValue(for: $0, species: sortSpecies)
            let s1 = severitySortValue(for: $1, species: sortSpecies)
            if s0 != s1 { return s0 > s1 }
            return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
    }

    var body: some View {
        ZStack {
            AppBackground()

            ScrollView {
                VStack(spacing: 0) {
                    // Species filter chips
                    if !isInformationalCategory {
                        speciesFilterChips
                    }

                    if isGridView {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(filteredItems) { item in
                                NavigationLink(value: item) {
                                    Image(item.imageAsset ?? "placeholder")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .padding(.bottom, 80)
                    } else {
                        LazyVStack(spacing: 4) {
                            ForEach(filteredItems) { item in
                                NavigationLink(value: item) {
                                    EntryListRow(
                                        item: item,
                                        selectedSpeciesFilter: selectedSpeciesFilter
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.bottom, 80)
                    }
                }
            }
        }
        .navigationTitle(category.displayName)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationDestination(for: ToxicItem.self) { item in
            ArticleDetailView(item: item, sourceCategory: category)
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                // Sort toggle (hide for Informational category)
                if !isInformationalCategory {
                    Button {
                        sortBySeverity.toggle()
                    } label: {
                        Image(systemName: sortBySeverity ? "exclamationmark.triangle" : "textformat.abc")
                    }
                }

                // Size toggle (only in grid view)
                if isGridView {
                    Button {
                        cycleGridSize()
                    } label: {
                        Image(systemName: gridIcon)
                    }
                }

                // View mode toggle
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isGridView.toggle()
                    }
                } label: {
                    Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                }
            }
        }
        .onAppear {
            // Do NOT clear isProgrammaticNavigation here — the BrowseView
            // onChange(of: navigationPath.count) observer may not have processed
            // a transient count=0 yet. Clearing here causes a race condition.
            navContext.enterCategoryList(category: category, entries: filteredItems)
        }
        .onChange(of: category) { _, _ in
            // When swipe navigation replaces the path at the same depth,
            // SwiftUI may reuse this view without firing .onAppear.
            // This ensures context updates for the new category.
            navContext.enterCategoryList(category: category, entries: filteredItems)
        }
        .onChange(of: sortBySeverity) { _, _ in
            navContext.updateVisibleEntries(filteredItems)
        }
        .onChange(of: selectedSpeciesFilter) { _, _ in
            navContext.updateVisibleEntries(filteredItems)
        }
    }

    // MARK: - Species Filter Chips

    private var speciesFilterChips: some View {
        VStack(spacing: 4) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    filterChip(title: "Auto", filter: .auto, icon: "sparkles")
                    filterChip(title: "All", filter: .all, icon: nil)
                    filterChip(title: "Dogs", filter: .specific(.dog), icon: "dog")
                    filterChip(title: "Cats", filter: .specific(.cat), icon: "cat")
                    filterChip(title: "Birds", filter: .specific(.bird), icon: "bird")
                    filterChip(title: "Small Mammals", filter: .specific(.smallMammal), icon: "hare")
                    filterChip(title: "Reptiles", filter: .specific(.reptile), icon: "lizard")
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 8)

            // Auto filter indicator
            if selectedSpeciesFilter == .auto, let species = autoFilterSpecies, !species.isEmpty {
                HStack(spacing: 4) {
                    Image(systemName: "pawprint.fill")
                        .font(.caption2)
                    Text("Showing: \(species.map { $0.displayName }.sorted().joined(separator: ", "))")
                        .font(.caption)
                    Spacer()
                }
                .foregroundColor(.teal)
                .padding(.horizontal, 16)
                .padding(.bottom, 4)
            } else if selectedSpeciesFilter == .auto && autoFilterSpecies == nil {
                HStack(spacing: 4) {
                    Image(systemName: "info.circle")
                        .font(.caption2)
                    Text("Add pets in Settings to personalize")
                        .font(.caption)
                    Spacer()
                }
                .foregroundColor(.secondary)
                .padding(.horizontal, 16)
                .padding(.bottom, 4)
            }
        }
    }

    @ViewBuilder
    private func filterChip(title: String, filter: SpeciesFilter, icon: String?) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedSpeciesFilter = filter
            }
        } label: {
            HStack(spacing: 4) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.caption)
                }
                Text(title)
                    .font(.caption)
                    .fontWeight(selectedSpeciesFilter == filter ? .semibold : .regular)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(selectedSpeciesFilter == filter ? Color.teal : Color.white.opacity(0.1))
            .foregroundColor(selectedSpeciesFilter == filter ? .white : .gray)
            .cornerRadius(16)
        }
    }

    // MARK: - Helper Methods

    /// Returns a numeric sort value for an item's severity.
    /// When a specific species is selected, uses that species' severity from speciesRisks.
    /// Otherwise falls back to entrySeverity.
    private func severitySortValue(for item: ToxicItem, species: Species?) -> Int {
        if let species = species,
           let speciesRisk = item.speciesRisks.first(where: { $0.species == species }) {
            return severityToInt(speciesRisk.severity)
        }

        if let entrySeverity = item.entrySeverity {
            return severityToInt(entrySeverity)
        }

        return 0
    }

    private func severityToInt(_ severity: Severity) -> Int {
        switch severity {
        case .severe: return 5
        case .high: return 4
        case .moderate: return 3
        case .lowModerate: return 2
        case .low: return 1
        }
    }

    private func cycleGridSize() {
        switch columnCount {
        case 1: columnCount = 2
        case 2: columnCount = 3
        case 3: columnCount = 1
        default: columnCount = 2
        }
    }

    private var gridIcon: String {
        switch columnCount {
        case 1: return "rectangle.grid.1x2"
        case 2: return "square.grid.2x2"
        case 3: return "square.grid.3x3"
        default: return "square.grid.2x2"
        }
    }
}

// MARK: - Entry List Row

struct EntryListRow: View {
    let item: ToxicItem
    let selectedSpeciesFilter: SpeciesFilter

    private var displaySeverity: Severity? {
        if case .specific(let species) = selectedSpeciesFilter,
           let risk = item.speciesRisks.first(where: { $0.species == species }) {
            return risk.severity
        }
        return item.entrySeverity
    }

    var body: some View {
        HStack(spacing: 12) {
            if let imageAsset = item.imageAsset {
                Image(imageAsset)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(2)
            }

            Spacer()

            if let severity = displaySeverity {
                SeverityBadge(severity: severity, size: .small)
            }

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.3))
                .font(.caption)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    BrowseView(navigationPath: .constant(NavigationPath()))
        .environment(BrowseNavigationContext())
}
