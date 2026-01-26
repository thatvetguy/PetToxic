import SwiftUI

struct HistoryListView: View {
    @ObservedObject var viewModel: SavedViewModel

    var body: some View {
        Group {
            if viewModel.recentlyViewed.isEmpty && viewModel.recentSearches.isEmpty {
                EmptyStateView(
                    "No History",
                    systemImage: "clock",
                    description: "Your recent searches and viewed items will appear here."
                )
            } else {
                List {
                    if !viewModel.recentSearches.isEmpty {
                        Section("Recent Searches") {
                            ForEach(viewModel.recentSearches, id: \.self) { search in
                                Label(search, systemImage: "magnifyingglass")
                                    .foregroundStyle(.white)
                            }
                            .listRowBackground(Color.white.opacity(0.08))
                        }
                    }

                    if !viewModel.recentlyViewed.isEmpty {
                        Section("Recently Viewed") {
                            ForEach(viewModel.recentlyViewed) { item in
                                NavigationLink(value: item) {
                                    historyRow(item)
                                }
                                .listRowBackground(Color.white.opacity(0.08))
                            }
                        }
                    }

                    // Extra space for tab bar
                    Section {
                        Color.clear.frame(height: 60)
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
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
                .foregroundStyle(.white.opacity(0.6))
                .frame(width: 24)

            Text(item.name)
                .font(.body)
                .foregroundColor(.white)

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        HistoryListView(viewModel: SavedViewModel())
    }
}
