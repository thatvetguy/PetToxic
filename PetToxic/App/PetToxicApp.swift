import SwiftUI
import SwiftData

@main
struct PetToxicApp: App {
    /// Navigation context for Browse tab - enables context-aware swipe gestures
    @State private var browseNavigationContext = BrowseNavigationContext()

    init() {
        #if DEBUG
        print("APP LAUNCHED")
        #endif
        // Initialize StoreKit service (loads products & checks entitlements)
        _ = StoreKitService.shared
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(browseNavigationContext)
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: [Pet.self, PoisonControlCase.self])
    }
}
