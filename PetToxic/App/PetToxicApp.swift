import SwiftUI
import SwiftData
import GoogleMobileAds

@main
struct PetToxicApp: App {
    /// Navigation context for Browse tab - enables context-aware swipe gestures
    @State private var browseNavigationContext = BrowseNavigationContext()

    init() {
        print("APP LAUNCHED")
        // Initialize Google Mobile Ads SDK
        MobileAds.shared.start()
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
