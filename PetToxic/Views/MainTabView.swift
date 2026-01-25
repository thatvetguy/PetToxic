import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    private let tabCount = 5

    var body: some View {
        TabView(selection: $selectedTab) {
            SearchView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
                .gesture(swipeGesture)

            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "square.grid.2x2")
                }
                .tag(1)
                .gesture(swipeGesture)

            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
                .tag(2)
                .gesture(swipeGesture)

            EmergencyView()
                .tabItem {
                    Label("Emergency", systemImage: "phone.fill")
                }
                .tag(3)
                .gesture(swipeGesture)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(4)
                .gesture(swipeGesture)
        }
        .tint(Color("AccentColor"))
    }

    private var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 50, coordinateSpace: .local)
            .onEnded { value in
                // Swipe right (positive x) = go to previous tab
                if value.translation.width > 50 && selectedTab > 0 {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selectedTab -= 1
                    }
                }
                // Swipe left (negative x) = go to next tab
                if value.translation.width < -50 && selectedTab < tabCount - 1 {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selectedTab += 1
                    }
                }
            }
    }
}

#Preview {
    MainTabView()
}
