import Foundation

/// AdMob configuration constants
enum AdMobConfig {
    /// Set to `false` for App Store release builds to use real ad unit IDs.
    /// Set to `true` during development/testing to use Google's test ads.
    static let useTestAds = false

    /// Banner ad unit ID — returns test or production ID based on `useTestAds` flag
    static var bannerAdUnitID: String {
        if useTestAds {
            // Google's official test banner ad unit ID
            return "ca-app-pub-3940256099942544/2435281174"
        } else {
            // Production banner ad unit ID (Pet Toxic - Bottom Banner)
            return "ca-app-pub-1396047890232162/8362632055"
        }
    }
}
