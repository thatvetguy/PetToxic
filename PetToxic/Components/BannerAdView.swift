import SwiftUI
import GoogleMobileAds

/// A SwiftUI wrapper for Google AdMob banner ads.
/// Uses adaptive banner sizing for optimal display across device sizes.
struct BannerAdView: UIViewRepresentable {

    func makeUIView(context: Context) -> BannerView {
        let bannerView = BannerView()
        bannerView.adUnitID = AdMobConfig.bannerAdUnitID

        // Get the root view controller for ad presentation
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            bannerView.rootViewController = rootViewController
        }

        // Use adaptive banner size based on screen width
        let viewWidth = UIScreen.main.bounds.width
        bannerView.adSize = currentOrientationAnchoredAdaptiveBanner(width: viewWidth)

        // Load the ad
        bannerView.load(Request())

        // Set background to clear so it blends with the app background
        bannerView.backgroundColor = .clear

        return bannerView
    }

    func updateUIView(_ uiView: BannerView, context: Context) {
        // No updates needed — the ad handles its own refresh cycle
    }
}
