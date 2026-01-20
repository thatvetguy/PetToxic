import SwiftUI

@main
struct PetToxicApp: App {
    @StateObject private var appearance = AppearanceSettings.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(appearance.colorScheme)
        }
    }
}
