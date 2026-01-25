import Foundation
import SwiftUI

/// Manages PRO subscription status with debug override support
class ProSettings: ObservableObject {
    static let shared = ProSettings()

    /// Debug override for PRO status (only works in DEBUG builds)
    #if DEBUG
    @AppStorage("debug_pro_enabled") var debugProEnabled: Bool = true
    #endif

    /// Whether the user has PRO access
    var isPro: Bool {
        #if DEBUG
        return debugProEnabled
        #else
        // TODO: Check actual subscription status via StoreKit
        return false
        #endif
    }

    /// Whether debug controls should be shown
    var showDebugControls: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    private init() {}
}
