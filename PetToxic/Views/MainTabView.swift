import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var dragOffset: CGFloat = 0
    @State private var isDragging = false

    private let tabCount = 5

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Tab content with offset animation
                tabContent(for: selectedTab)
                    .offset(x: dragOffset)

                // Preview of adjacent tab during drag
                if isDragging {
                    if dragOffset > 0 {
                        // Dragging right - show previous tab (or Emergency from Home)
                        let prevTab = selectedTab == 0 ? 3 : selectedTab - 1
                        tabContent(for: prevTab)
                            .offset(x: dragOffset - geometry.size.width)
                    } else if dragOffset < 0 && selectedTab < tabCount - 1 {
                        // Dragging left - show next tab
                        tabContent(for: selectedTab + 1)
                            .offset(x: dragOffset + geometry.size.width)
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        isDragging = true
                        let translation = value.translation.width

                        // Dragging right (to go left/previous)
                        if translation > 0 {
                            // Home can go to Emergency, others go to previous
                            dragOffset = translation
                        }
                        // Dragging left (to go right/next)
                        else if translation < 0 {
                            if selectedTab < tabCount - 1 {
                                dragOffset = translation
                            } else {
                                // Settings - add resistance
                                dragOffset = translation * 0.3
                            }
                        }
                    }
                    .onEnded { value in
                        let threshold = geometry.size.width * 0.25
                        let translation = value.translation.width

                        withAnimation(.easeOut(duration: 0.25)) {
                            // Swipe right - go to previous (or Emergency from Home)
                            if translation > threshold {
                                if selectedTab == 0 {
                                    selectedTab = 3 // Home → Emergency
                                } else {
                                    selectedTab -= 1
                                }
                            }
                            // Swipe left - go to next
                            else if translation < -threshold && selectedTab < tabCount - 1 {
                                selectedTab += 1
                            }

                            // Reset offset
                            dragOffset = 0
                            isDragging = false
                        }
                    }
            )
        }
        // Tab bar at bottom
        .safeAreaInset(edge: .bottom) {
            customTabBar
        }
    }

    @ViewBuilder
    private func tabContent(for index: Int) -> some View {
        switch index {
        case 0:
            SearchView()
        case 1:
            BrowseView()
        case 2:
            SavedView()
        case 3:
            EmergencyView()
        case 4:
            SettingsView()
        default:
            EmptyView()
        }
    }

    private var customTabBar: some View {
        HStack {
            tabBarButton(icon: "house.fill", title: "Home", index: 0)
            tabBarButton(icon: "square.grid.2x2.fill", title: "Browse", index: 1)
            tabBarButton(icon: "bookmark.fill", title: "Saved", index: 2)
            tabBarButton(icon: "phone.fill", title: "Emergency", index: 3)
            tabBarButton(icon: "gearshape.fill", title: "Settings", index: 4)
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            Color.black.opacity(0.9)
                .ignoresSafeArea(edges: .bottom)
        )
    }

    private func tabBarButton(icon: String, title: String, index: Int) -> some View {
        Button(action: {
            withAnimation(.easeOut(duration: 0.25)) {
                selectedTab = index
            }
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                Text(title)
                    .font(.caption2)
            }
            .foregroundColor(selectedTab == index ? Color("AccentColor") : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    MainTabView()
}
