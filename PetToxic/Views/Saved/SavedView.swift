import SwiftUI

struct SavedView: View {
    @State private var selectedTab = 0
    @StateObject private var viewModel = SavedViewModel()
    @ObservedObject private var proSettings = ProSettings.shared

    private var isProUser: Bool { proSettings.isPro }

    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()

                VStack(spacing: 0) {
                    Picker("View", selection: $selectedTab) {
                        Text("Bookmarks").tag(0)
                        Text("History").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    if selectedTab == 0 {
                        BookmarksListView(viewModel: viewModel)
                    } else {
                        HistoryListView(viewModel: viewModel)
                    }

                    Spacer(minLength: 0)

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
            .navigationTitle("Saved")
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: ToxicItem.self) { item in
                ArticleDetailView(item: item)
            }
        }
    }
}

#Preview {
    SavedView()
}
