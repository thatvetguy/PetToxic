import SwiftUI

struct BookmarksListView: View {
    @ObservedObject var viewModel: SavedViewModel

    var body: some View {
        Group {
            if viewModel.bookmarks.isEmpty {
                EmptyStateView(
                    "No Bookmarks",
                    systemImage: "bookmark",
                    description: "Tap the bookmark icon on any article to save it here."
                )
            } else {
                List {
                    ForEach(viewModel.bookmarks) { item in
                        NavigationLink(value: item) {
                            bookmarkRow(item)
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.removeBookmarks(at: indexSet)
                    }
                }
            }
        }
    }

    private func bookmarkRow(_ item: ToxicItem) -> some View {
        HStack {
            Image(systemName: item.categories.first?.icon ?? "questionmark.circle")
                .foregroundStyle(.secondary)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                Text(item.categories.map(\.displayName).joined(separator: ", "))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if let maxSeverity = item.speciesRisks.map(\.severity).max(by: { severityOrder($0) < severityOrder($1) }) {
                SeverityBadge(severity: maxSeverity)
            }
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
    NavigationStack {
        BookmarksListView(viewModel: SavedViewModel())
    }
}
