import SwiftUI
import SwiftData

@main
struct PetToxicApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: Pet.self)
    }
}
