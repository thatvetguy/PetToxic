import Foundation
import SwiftUI

/// Manages PRO subscription status with debug override support
class ProSettings: ObservableObject {
    static let shared = ProSettings()

    /// Debug override for PRO status (accessible via Developer Options)
    @AppStorage("debug_pro_enabled") private var _debugProEnabled: Bool = true

    /// Debug override for Supporter status (accessible via Developer Options)
    @AppStorage("debug_supporter_enabled") private var _debugSupporterEnabled: Bool = false

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

    /// Debug Supporter enabled (published for SwiftUI binding)
    var debugSupporterEnabled: Bool {
        get { _debugSupporterEnabled }
        set {
            _debugSupporterEnabled = newValue
            objectWillChange.send()
        }
    }

    /// Whether the user has PRO access
    var isPro: Bool {
        // TODO: Check actual subscription status via StoreKit
        // For now, use debug override (accessible via Developer Options)
        return _debugProEnabled
    }

    /// Whether the user is a Supporter-tier subscriber
    var isSupporter: Bool {
        // TODO: Check actual subscription status via StoreKit
        // For now, use debug override (accessible via Developer Options)
        return _debugSupporterEnabled
    }

    /// Whether PRO override is available (enabled when Developer Options are unlocked)
    var canOverridePro: Bool {
        return true
    }

    private init() {}
}
