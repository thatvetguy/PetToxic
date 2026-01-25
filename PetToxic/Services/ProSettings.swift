import Foundation
import SwiftUI

/// Manages PRO subscription status with debug override support
class ProSettings: ObservableObject {
    static let shared = ProSettings()

    /// Debug override for PRO status (only works in DEBUG builds)
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
        #if DEBUG
        return _debugProEnabled
        #else
        // TODO: Check actual subscription status via StoreKit
        return false
        #endif
    }

    /// Whether PRO override is available (only in DEBUG builds)
    var canOverridePro: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    private init() {}
}
