import SwiftUI

struct BrowseView: View {
    @StateObject private var viewModel = BrowseViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
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
            }
            .navigationTitle("Pick your poison...")
            .navigationDestination(for: Category.self) { category in
                CategoryListView(category: category)
            }
        }
    }
}

struct CategoryListView: View {
    let category: Category
    @StateObject private var viewModel = BrowseViewModel()
    @AppStorage("gridColumnCount") private var columnCount: Int = 2
    @AppStorage("entrySortBySeverity") private var sortBySeverity: Bool = true

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 8), count: columnCount)
    }

    private var isInformationalCategory: Bool {
        category == .informational
    }

    private var sortedItems: [ToxicItem] {
        let items = viewModel.items(for: category)

        // Informational category always sorts alphabetically
        if isInformationalCategory || !sortBySeverity {
            return items.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        }

        // Sort by severity (highest first)
        return items.sorted { maxSeverity(for: $0) > maxSeverity(for: $1) }
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(sortedItems) { item in
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
        }
        .navigationTitle(category.displayName)
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

    private func maxSeverity(for item: ToxicItem) -> Int {
        let severityOrder: [Severity: Int] = [
            .severe: 4,
            .high: 3,
            .moderate: 2,
            .low: 1
        ]
        return item.speciesRisks.map { severityOrder[$0.severity] ?? 0 }.max() ?? 0
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
