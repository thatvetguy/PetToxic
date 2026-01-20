import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(0)

            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "square.grid.2x2")
                }
                .tag(1)

            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
                .tag(2)

            EmergencyView()
                .tabItem {
                    Label("Emergency", systemImage: "phone.fill")
                }
                .tag(3)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(4)
        }
        .tint(Color("AccentColor"))
    }
}

#Preview {
    MainTabView()
}
