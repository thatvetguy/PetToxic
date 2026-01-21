import SwiftUI

enum AppearanceMode: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }

    var icon: String {
        switch self {
        case .system: return "circle.lefthalf.filled"
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }
}

@MainActor
final class AppearanceSettings: ObservableObject {
    static let shared = AppearanceSettings()

    private let key = "appearanceMode"

    @Published var mode: AppearanceMode {
        didSet {
            UserDefaults.standard.set(mode.rawValue, forKey: key)
        }
    }

    var colorScheme: ColorScheme? {
        mode.colorScheme
    }

    private init() {
        if let saved = UserDefaults.standard.string(forKey: key),
           let mode = AppearanceMode(rawValue: saved) {
            self.mode = mode
        } else {
            self.mode = .dark
        }
    }
}
