import SwiftUI
import AppTrackingTransparency
import Combine

/// Direction of a completed swipe gesture
private enum SwipeDirection {
    case back    // left-to-right finger movement (→) - goes to previous
    case forward // right-to-left finger movement (←) - goes to next
}

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var dragOffset: CGFloat = 0
    @State private var isDragging = false
    /// Flag to block NavigationLink taps during/after swipe - prevents accidental category opening
    @State private var isSwipeBlocking = false
    /// Blocks gesture recognition during tab-change animation to prevent stale-timer race conditions
    @State private var isAnimatingTransition = false
    @State private var isInQuickEmergency = false
    /// Navigation path for Browse tab - enables programmatic navigation for contextual swipes
    @State private var browseNavigationPath = NavigationPath()
    @AppStorage("disclaimerAcknowledgedVersion") private var acknowledgedVersion: String = ""
    @State private var showDisclaimerPopup = false
    @State private var isKeyboardVisible = false
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

                // Quick Emergency exit button
                if isInQuickEmergency && !isDragging {
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                withAnimation(.easeOut(duration: 0.25)) {
                                    isInQuickEmergency = false
                                }
                            } label: {
                                HStack(spacing: 4) {
                                    Text("Home")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(AppColors.teal.opacity(0.6))
                                .clipShape(Capsule())
                            }
                            .padding(.trailing, 16)
                            .padding(.top, 8)
                        }
                        Spacer()
                    }
                }
            }
            .simultaneousGesture(dragGesture(geometry: geometry))
        }
        .safeAreaInset(edge: .bottom) {
            customTabBar
                .opacity(isKeyboardVisible ? 0 : 1)
                .allowsHitTesting(!isKeyboardVisible)
        }
        .onAppear {
            let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"
            if acknowledgedVersion != currentVersion {
                showDisclaimerPopup = true
            }

            // Request App Tracking Transparency authorization after a brief delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                ATTrackingManager.requestTrackingAuthorization { _ in
                    // No action needed — ads still serve regardless of choice
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            withAnimation(.easeOut(duration: 0.25)) {
                isKeyboardVisible = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation(.easeOut(duration: 0.25)) {
                isKeyboardVisible = false
            }
        }
        .sheet(isPresented: $showDisclaimerPopup) {
            DisclaimerPopupView(isPresented: $showDisclaimerPopup)
                .presentationDragIndicator(.hidden)
        }
    }

    @ViewBuilder
    private func adjacentTabPreview(geometry: GeometryProxy) -> some View {
        if selectedTab == 1 && browseNavigationPath.count > 0 {
            // Contextual navigation (entry/category swiping) — no adjacent tab preview
            EmptyView()
        } else if isInQuickEmergency {
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
                guard !isAnimatingTransition else { return }
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

                // Block NavigationLink taps immediately when swipe is detected
                isSwipeBlocking = true
                isDragging = true
                let translation = value.translation.width

                // Don't slide content during contextual navigation (entry/category swipes).
                // The swipe is detected by threshold/velocity in onEnded, not by dragOffset.
                if selectedTab == 1 && browseNavigationPath.count > 0 {
                    return
                }

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
                guard !isAnimatingTransition else { return }

                // Exclude drags that started in the filter bar area
                let startY = value.startLocation.y
                if startY >= 120 && startY <= 260 {
                    isAnimatingTransition = true
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        dragOffset = 0
                    }
                    // Delay resetting to ensure touch-up doesn't trigger NavigationLink
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isDragging = false
                        isSwipeBlocking = false
                        isAnimatingTransition = false
                    }
                    return
                }

                let screenWidth = geometry.size.width
                let translation = value.translation.width
                let velocity = value.predictedEndTranslation.width - value.translation.width
                let isContextualSwipe = selectedTab == 1 && browseNavigationPath.count > 0

                // For contextual swipes, the ScrollView's gesture can prevent
                // isDragging from being set in onChanged. Check the final
                // translation directly instead — it's more reliable.
                if !isDragging {
                    if isContextualSwipe {
                        let horizontal = abs(translation)
                        let vertical = abs(value.translation.height)
                        guard horizontal > vertical else {
                            return
                        }
                    } else {
                        dragOffset = 0
                        return
                    }
                }
                let threshold = isContextualSwipe
                    ? screenWidth * 0.10   // ~40pt — light flick
                    : screenWidth * 0.20   // ~80pt — visual slide
                let velocityThreshold: CGFloat = isContextualSwipe ? 100 : 200

                // Consider velocity for quick flicks
                let shouldSwipeLeft = translation < -threshold || velocity < -velocityThreshold
                let shouldSwipeRight = translation > threshold || velocity > velocityThreshold

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
                // Use the actual navigation path count as source of truth,
                // not browseNavContext.depth which can become stale.
                if let direction = direction,
                   selectedTab == 1 && browseNavigationPath.count > 0 {
                    // Handle contextual swipe (entry/category navigation)
                    if browseNavigationPath.count >= 2 {
                        handleEntryLevelSwipe(direction: direction)
                    } else {
                        handleCategoryLevelSwipe(direction: direction)
                    }
                    // Reset drag state
                    isAnimatingTransition = true
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        dragOffset = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isDragging = false
                        isSwipeBlocking = false
                        isAnimatingTransition = false
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

                    isAnimatingTransition = true
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
                        isSwipeBlocking = false
                        isAnimatingTransition = false
                    }
                } else {
                    // Snap back — no tab change
                    isAnimatingTransition = true
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                        dragOffset = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isDragging = false
                        isSwipeBlocking = false
                        isAnimatingTransition = false
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
            // If we just popped to root, update context
            if browseNavigationPath.isEmpty {
                browseNavContext.returnToGrid()
            }
        }
    }

    private func popToGrid() {
        browseNavigationPath = NavigationPath()
        browseNavContext.returnToGrid()
    }

    private func navigateToPreviousEntry() {
        guard let currentIndex = browseNavContext.currentEntryIndex, currentIndex > 0 else { return }
        browseNavContext.navigateToEntryAtIndex(currentIndex - 1)
    }

    private func navigateToNextEntry() {
        guard let currentIndex = browseNavContext.currentEntryIndex,
              currentIndex < browseNavContext.visibleEntries.count - 1 else { return }
        browseNavContext.navigateToEntryAtIndex(currentIndex + 1)
    }

    private func navigateToPreviousCategory() {
        guard let previousCategory = browseNavContext.previousCategory else { return }
        var newPath = NavigationPath()
        newPath.append(previousCategory)
        browseNavigationPath = newPath
    }

    private func navigateToNextCategory() {
        guard let nextCategory = browseNavContext.nextCategory else { return }
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
            BrowseView(navigationPath: $browseNavigationPath, isSwipeBlocking: isSwipeBlocking)
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
                    .font(.title3)
                Text(title)
                    .font(.caption2)
            }
            // Highlight: Home stays selected when in quick emergency
            .foregroundColor(tabIsSelected(index) ? Color("AccentColor") : .white.opacity(0.6))
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
