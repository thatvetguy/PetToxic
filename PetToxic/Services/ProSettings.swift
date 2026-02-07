import Foundation
import SwiftUI

/// Manages PRO subscription status with debug override support
class ProSettings: ObservableObject {
    static let shared = ProSettings()

    /// Debug override for PRO status (accessible via Developer Options)
    @AppStorage("debug_pro_enabled") private var _debugProEnabled: Bool = true

    /// Debug override for Supporter status (accessible via Developer Options)
    @AppStorage("debug_supporter_enabled") private var _debugSupporterEnabled: Bool = false

    /// StoreKit purchase state (cached in UserDefaults, re-verified on launch)
    @AppStorage("purchased_pro") private var _purchasedPro: Bool = false
    @AppStorage("purchased_supporter") private var _purchasedSupporter: Bool = false

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

    /// Whether the user has PRO access (debug override OR real purchase)
    var isPro: Bool {
        return _debugProEnabled || _purchasedPro || _purchasedSupporter
    }

    /// Whether the user is a Pet Hero subscriber (debug override OR real purchase)
    var isSupporter: Bool {
        return _debugSupporterEnabled || _purchasedSupporter
    }

    /// Called by StoreKitService when purchase state changes
    func setPurchasedPro(_ value: Bool) {
        _purchasedPro = value
        objectWillChange.send()
    }

    /// Called by StoreKitService when purchase state changes
    func setPurchasedSupporter(_ value: Bool) {
        _purchasedSupporter = value
        objectWillChange.send()
    }

    private init() {}
}
