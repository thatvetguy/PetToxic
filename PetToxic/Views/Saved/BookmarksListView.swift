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
                        .listRowBackground(Color.white.opacity(0.08))
                    }
                    .onDelete { indexSet in
                        viewModel.removeBookmarks(at: indexSet)
                    }

                    // Extra space for tab bar
                    Section {
                        Color.clear.frame(height: 60)
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
            }
        }
    }

    private func bookmarkRow(_ item: ToxicItem) -> some View {
        HStack {
            Image(systemName: item.categories.first?.icon ?? "questionmark.circle")
                .foregroundStyle(.white.opacity(0.6))
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(item.categories.map(\.displayName).joined(separator: ", "))
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }

            Spacer()

            if let severity = item.entrySeverity {
                SeverityBadge(severity: severity)
            } else if let maxSeverity = item.speciesRisks.map(\.severity).max() {
                SeverityBadge(severity: maxSeverity)
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookmarksListView(viewModel: SavedViewModel())
    }
}
