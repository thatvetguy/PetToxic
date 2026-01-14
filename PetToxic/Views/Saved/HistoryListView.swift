import SwiftUI

struct HistoryListView: View {
    @ObservedObject var viewModel: SavedViewModel

    var body: some View {
        Group {
            if viewModel.recentlyViewed.isEmpty && viewModel.recentSearches.isEmpty {
                ContentUnavailableView(
                    "No History",
                    systemImage: "clock",
                    description: Text("Your recent searches and viewed items will appear here.")
                )
            } else {
                List {
                    if !viewModel.recentSearches.isEmpty {
                        Section("Recent Searches") {
                            ForEach(viewModel.recentSearches, id: \.self) { search in
                                Label(search, systemImage: "magnifyingglass")
                                    .foregroundStyle(.primary)
                            }
                        }
                    }

                    if !viewModel.recentlyViewed.isEmpty {
                        Section("Recently Viewed") {
                            ForEach(viewModel.recentlyViewed) { item in
                                NavigationLink(value: item) {
                                    historyRow(item)
                                }
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Clear") {
                            viewModel.clearHistory()
                        }
                    }
                }
            }
        }
    }

    private func historyRow(_ item: ToxicItem) -> some View {
        HStack {
            Image(systemName: item.categories.first?.icon ?? "questionmark.circle")
                .foregroundStyle(.secondary)
                .frame(width: 24)

            Text(item.name)
                .font(.body)

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        HistoryListView(viewModel: SavedViewModel())
    }
}
