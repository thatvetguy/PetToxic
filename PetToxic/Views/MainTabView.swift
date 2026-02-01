import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var dragOffset: CGFloat = 0
    @State private var isDragging = false
    @State private var isInQuickEmergency = false

    private let tabCount = 5

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Current visible content
                if isInQuickEmergency {
                    // Show Emergency content when in quick-access mode
                    EmergencyView()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: dragOffset)
                } else {
                    // Normal tab content
                    tabContent(for: selectedTab)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: dragOffset)
                }

                // Preview of adjacent tab during drag
                if isDragging {
                    adjacentTabPreview(geometry: geometry)
                }
            }
            .simultaneousGesture(dragGesture(geometry: geometry))
        }
        .safeAreaInset(edge: .bottom) {
            customTabBar
        }
    }

    @ViewBuilder
    private func adjacentTabPreview(geometry: GeometryProxy) -> some View {
        if isInQuickEmergency {
            // In quick emergency: only Home is to the right (swipe left to return)
            if dragOffset < 0 {
                tabContent(for: 0) // Home
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: dragOffset + geometry.size.width)
            }
            // Nothing to the left (dragOffset > 0 shows nothing)
        } else if selectedTab == 0 {
            // On Home: Emergency quick-access to the left (swipe right reveals it)
            if dragOffset > 0 {
                EmergencyView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: dragOffset - geometry.size.width)
            }
            // Browse to the right (swipe left)
            if dragOffset < 0 {
                tabContent(for: 1)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: dragOffset + geometry.size.width)
            }
        } else {
            // Normal tab behavior
            if dragOffset > 0 && selectedTab > 0 {
                tabContent(for: selectedTab - 1)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: dragOffset - geometry.size.width)
            }
            if dragOffset < 0 && selectedTab < tabCount - 1 {
                tabContent(for: selectedTab + 1)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: dragOffset + geometry.size.width)
            }
        }
    }

    private func dragGesture(geometry: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 20)
            .onChanged { value in
                let horizontal = abs(value.translation.width)
                let vertical = abs(value.translation.height)

                // Only engage horizontal swipe if clearly horizontal
                guard horizontal > vertical * 1.5 else {
                    return
                }

                isDragging = true
                let translation = value.translation.width

                if isInQuickEmergency {
                    // In quick emergency mode
                    if translation < 0 {
                        // Swiping left - can go back to Home
                        dragOffset = translation
                    } else {
                        // Swiping right - nothing there, add resistance
                        dragOffset = translation * 0.3
                    }
                } else if selectedTab == 0 {
                    // On Home - can go either direction
                    dragOffset = translation
                } else if selectedTab == tabCount - 1 {
                    // On Settings (last tab)
                    if translation > 0 {
                        // Swiping right - go to Emergency
                        dragOffset = translation
                    } else {
                        // Swiping left - nothing there, add resistance
                        dragOffset = translation * 0.3
                    }
                } else {
                    // Normal middle tabs
                    dragOffset = translation
                }
            }
            .onEnded { value in
                // If we never engaged (vertical drag), just reset
                guard isDragging else {
                    dragOffset = 0
                    return
                }

                isDragging = false
                let threshold = geometry.size.width * 0.20
                let translation = value.translation.width
                let velocity = value.predictedEndTranslation.width - value.translation.width

                // Consider velocity for quick flicks
                let shouldSwipeLeft = translation < -threshold || velocity < -200
                let shouldSwipeRight = translation > threshold || velocity > 200

                withAnimation(.easeOut(duration: 0.2)) {
                    if isInQuickEmergency {
                        // In quick emergency mode
                        if shouldSwipeLeft {
                            // Swipe left - return to Home
                            isInQuickEmergency = false
                            selectedTab = 0
                        }
                        // Swipe right does nothing (already at edge)
                    } else if selectedTab == 0 {
                        // On Home
                        if shouldSwipeRight {
                            // Swipe right - enter quick Emergency
                            isInQuickEmergency = true
                        } else if shouldSwipeLeft {
                            // Swipe left - go to Browse
                            selectedTab = 1
                        }
                    } else {
                        // Normal tab navigation
                        if shouldSwipeRight && selectedTab > 0 {
                            selectedTab -= 1
                        } else if shouldSwipeLeft && selectedTab < tabCount - 1 {
                            selectedTab += 1
                        }
                    }

                    // Reset offset
                    dragOffset = 0
                }
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
                // Tapping any tab exits quick emergency mode
                isInQuickEmergency = false
                selectedTab = index
            }
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                Text(title)
                    .font(.caption2)
            }
            // Highlight: Home stays selected when in quick emergency
            .foregroundColor(tabIsSelected(index) ? Color("AccentColor") : .gray)
            .frame(maxWidth: .infinity)
        }
    }

    private func tabIsSelected(_ index: Int) -> Bool {
        if isInQuickEmergency {
            // In quick emergency, keep Home highlighted (user's "anchor" point)
            return index == 0
        }
        return selectedTab == index
    }
}

#Preview {
    MainTabView()
}
