import SwiftUI

/// Direction of a completed swipe gesture
private enum SwipeDirection {
    case back    // left-to-right finger movement (→) - goes to previous
    case forward // right-to-left finger movement (←) - goes to next
}

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var dragOffset: CGFloat = 0
    @State private var isDragging = false
    @State private var isInQuickEmergency = false
    /// Navigation path for Browse tab - enables programmatic navigation for contextual swipes
    @State private var browseNavigationPath = NavigationPath()
    @AppStorage("disclaimerAcknowledgedVersion") private var acknowledgedVersion: String = ""
    @State private var showDisclaimerPopup = false
    @Environment(BrowseNavigationContext.self) private var browseNavContext

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
        .onAppear {
            let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"
            if acknowledgedVersion != currentVersion {
                showDisclaimerPopup = true
            }
        }
        .sheet(isPresented: $showDisclaimerPopup) {
            DisclaimerPopupView(isPresented: $showDisclaimerPopup)
                .presentationDragIndicator(.hidden)
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
                // Exclude drags starting in the species filter bar area
                // to allow horizontal ScrollView scrolling on filter chips
                let startY = value.startLocation.y
                if startY >= 120 && startY <= 260 {
                    return
                }

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
                // Exclude drags that started in the filter bar area
                let startY = value.startLocation.y
                if startY >= 120 && startY <= 260 {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        dragOffset = 0
                    }
                    isDragging = false
                    return
                }

                // If we never engaged (vertical drag), just reset
                guard isDragging else {
                    dragOffset = 0
                    return
                }

                let threshold = geometry.size.width * 0.20
                let screenWidth = geometry.size.width
                let translation = value.translation.width
                let velocity = value.predictedEndTranslation.width - value.translation.width

                // Consider velocity for quick flicks
                let shouldSwipeLeft = translation < -threshold || velocity < -200
                let shouldSwipeRight = translation > threshold || velocity > 200

                // Determine swipe direction (if valid)
                let direction: SwipeDirection?
                if shouldSwipeRight {
                    direction = .back
                } else if shouldSwipeLeft {
                    direction = .forward
                } else {
                    direction = nil
                }

                // Check for contextual navigation on Browse tab
                if let direction = direction,
                   selectedTab == 1 && !browseNavContext.isAtGridLevel {
                    // Handle contextual swipe (entry/category navigation)
                    if browseNavContext.isAtEntryLevel {
                        handleEntryLevelSwipe(direction: direction)
                    } else if browseNavContext.isAtCategoryLevel {
                        handleCategoryLevelSwipe(direction: direction)
                    }
                    // Reset drag state
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        dragOffset = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isDragging = false
                    }
                    return
                }

                // Default: Determine target tab
                var canChangeTab = false
                var newTab = selectedTab
                var enterEmergency = false
                var exitEmergency = false

                if isInQuickEmergency {
                    if shouldSwipeLeft {
                        canChangeTab = true
                        exitEmergency = true
                        newTab = 0
                    }
                } else if selectedTab == 0 {
                    if shouldSwipeRight {
                        canChangeTab = true
                        enterEmergency = true
                    } else if shouldSwipeLeft && selectedTab < tabCount - 1 {
                        canChangeTab = true
                        newTab = 1
                    }
                } else {
                    if shouldSwipeRight && selectedTab > 0 {
                        canChangeTab = true
                        newTab = selectedTab - 1
                    } else if shouldSwipeLeft && selectedTab < tabCount - 1 {
                        canChangeTab = true
                        newTab = selectedTab + 1
                    }
                }

                if canChangeTab {
                    // PHASE 1: Animate current view sliding OFF screen
                    // Keep isDragging true so adjacent preview stays visible
                    let targetOffset = shouldSwipeLeft ? -screenWidth : screenWidth

                    withAnimation(.easeOut(duration: 0.25)) {
                        dragOffset = targetOffset
                    }

                    // PHASE 2: After slide completes, swap content and reset
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        if exitEmergency {
                            isInQuickEmergency = false
                        }
                        if enterEmergency {
                            isInQuickEmergency = true
                        }
                        selectedTab = newTab
                        dragOffset = 0
                        isDragging = false
                    }
                } else {
                    // Snap back — no tab change
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                        dragOffset = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isDragging = false
                    }
                }
            }
    }

    // MARK: - Contextual Swipe Navigation

    /// Handles swipe when viewing an entry detail
    private func handleEntryLevelSwipe(direction: SwipeDirection) {
        guard browseNavContext.hasContext else {
            // No context (from search or related link) - pop back on swipe back
            if direction == .back {
                popNavigation()
            }
            return
        }

        switch direction {
        case .back:
            if browseNavContext.canSwipeToPreviousEntry {
                navigateToPreviousEntry()
            } else {
                popNavigation()
            }
        case .forward:
            if browseNavContext.canSwipeToNextEntry {
                navigateToNextEntry()
            } else {
                popNavigation()
            }
        }
    }

    /// Handles swipe when viewing a category list
    private func handleCategoryLevelSwipe(direction: SwipeDirection) {
        switch direction {
        case .back:
            if browseNavContext.canSwipeToPreviousCategory {
                navigateToPreviousCategory()
            } else {
                popToGrid()
            }
        case .forward:
            if browseNavContext.canSwipeToNextCategory {
                navigateToNextCategory()
            } else {
                popToGrid()
            }
        }
    }

    // MARK: - Navigation Helpers

    private func popNavigation() {
        if !browseNavigationPath.isEmpty {
            browseNavigationPath.removeLast()
        }
    }

    private func popToGrid() {
        browseNavigationPath = NavigationPath()
    }

    private func navigateToPreviousEntry() {
        guard let previousEntry = browseNavContext.previousEntry,
              let category = browseNavContext.currentCategory else { return }
        // Flag prevents returnToGrid from firing on transient path count=0
        browseNavContext.isProgrammaticNavigation = true
        var newPath = NavigationPath()
        newPath.append(category)
        newPath.append(previousEntry)
        browseNavigationPath = newPath
        if let currentIndex = browseNavContext.currentEntryIndex, currentIndex > 0 {
            browseNavContext.navigateToEntryAtIndex(currentIndex - 1)
        }
    }

    private func navigateToNextEntry() {
        guard let nextEntry = browseNavContext.nextEntry,
              let category = browseNavContext.currentCategory else { return }
        browseNavContext.isProgrammaticNavigation = true
        var newPath = NavigationPath()
        newPath.append(category)
        newPath.append(nextEntry)
        browseNavigationPath = newPath
        if let currentIndex = browseNavContext.currentEntryIndex {
            browseNavContext.navigateToEntryAtIndex(currentIndex + 1)
        }
    }

    private func navigateToPreviousCategory() {
        guard let previousCategory = browseNavContext.previousCategory else { return }
        browseNavContext.isProgrammaticNavigation = true
        var newPath = NavigationPath()
        newPath.append(previousCategory)
        browseNavigationPath = newPath
    }

    private func navigateToNextCategory() {
        guard let nextCategory = browseNavContext.nextCategory else { return }
        browseNavContext.isProgrammaticNavigation = true
        var newPath = NavigationPath()
        newPath.append(nextCategory)
        browseNavigationPath = newPath
    }

    @ViewBuilder
    private func tabContent(for index: Int) -> some View {
        switch index {
        case 0:
            SearchView()
        case 1:
            BrowseView(navigationPath: $browseNavigationPath)
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
