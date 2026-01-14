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
            .navigationTitle("Browse")
            .navigationDestination(for: Category.self) { category in
                CategoryListView(category: category)
            }
        }
    }
}

struct CategoryListView: View {
    let category: Category
    @StateObject private var viewModel = BrowseViewModel()

    var body: some View {
        List(viewModel.items(for: category)) { item in
            NavigationLink(value: item) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.description)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }

                    Spacer()

                    if let maxSeverity = item.speciesRisks.map(\.severity).max(by: { severityOrder($0) < severityOrder($1) }) {
                        SeverityBadge(severity: maxSeverity)
                    }
                }
            }
        }
        .navigationTitle(category.displayName)
        .navigationDestination(for: ToxicItem.self) { item in
            ArticleDetailView(item: item)
        }
    }

    private func severityOrder(_ severity: Severity) -> Int {
        switch severity {
        case .low: return 0
        case .moderate: return 1
        case .high: return 2
        case .severe: return 3
        }
    }
}

#Preview {
    BrowseView()
}
