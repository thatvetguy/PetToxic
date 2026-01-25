import Foundation
import SwiftUI

/// Manages PRO subscription status with debug override support
class ProSettings: ObservableObject {
    static let shared = ProSettings()

    /// Debug override for PRO status (accessible via Developer Options)
    @AppStorage("debug_pro_enabled") private var _debugProEnabled: Bool = true

    /// Whether developer options have been unlocked via easter egg
    @AppStorage("developer_options_unlocked") var developerOptionsUnlocked: Bool = false

    /// Debug PRO enabled (published for SwiftUI binding)
    var debugProEnabled: Bool {
        get { _debugProEnabled }
        set {
            _debugProEnabled = newValue
            objectWillChange.send()
        }
    }

    /// Whether the user has PRO access
    var isPro: Bool {
        // TODO: Check actual subscription status via StoreKit
        // For now, use debug override (accessible via Developer Options)
        return _debugProEnabled
    }

    /// Whether PRO override is available (enabled when Developer Options are unlocked)
    var canOverridePro: Bool {
        return true
    }

    private init() {}
}
