import SwiftUI
import SwiftData

struct BrowseView: View {
    @StateObject private var viewModel = BrowseViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()

                ScrollView {
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
                    .padding(.bottom, 80) // Extra space for tab bar
                }
            }
            .navigationTitle("Pick your poison...")
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: Category.self) { category in
                CategoryListView(category: category)
            }
        }
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
    @State private var selectedSpeciesFilter: SpeciesFilter = .auto

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

        // Sort by severity (highest first)
        return speciesFiltered.sorted { maxSeverity(for: $0) > maxSeverity(for: $1) }
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
                    .padding(.bottom, 80) // Extra space for tab bar
                }
            }
        }
        .navigationTitle(category.displayName)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationDestination(for: ToxicItem.self) { item in
            ArticleDetailView(item: item)
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

                // Size toggle (always visible)
                Button {
                    cycleGridSize()
                } label: {
                    Image(systemName: gridIcon)
                }
            }
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

    private func maxSeverity(for item: ToxicItem) -> Int {
        // Use entrySeverity if available, otherwise fall back to computed max from speciesRisks
        if let entrySeverity = item.entrySeverity {
            switch entrySeverity {
            case .severe: return 5
            case .high: return 4
            case .moderate: return 3
            case .lowModerate: return 2
            case .low: return 1
            }
        }
        // Fallback for items without entrySeverity (Informational entries sort last)
        return 0
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

#Preview {
    BrowseView()
}
