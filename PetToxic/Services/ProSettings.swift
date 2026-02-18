import Foundation
import SwiftUI
import Combine

/// Manages PRO subscription status with debug override support
class ProSettings: ObservableObject {
    static let shared = ProSettings()

    #if DEBUG
    /// Debug override for PRO status (accessible via Developer Options)
    @AppStorage("debug_pro_enabled") private var _debugProEnabled: Bool = false

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
    #endif

    /// StoreKit purchase state (cached in UserDefaults, re-verified on launch)
    @AppStorage("purchased_pro") private var _purchasedPro: Bool = false
    @AppStorage("purchased_supporter") private var _purchasedSupporter: Bool = false

    /// Whether the user has PRO access (debug override, real purchase, OR active trial)
    var isPro: Bool {
        #if DEBUG
        return _debugProEnabled || _purchasedPro || _purchasedSupporter || TrialManager.shared.isTrialActive
        #else
        return _purchasedPro || _purchasedSupporter || TrialManager.shared.isTrialActive
        #endif
    }

    /// Whether the user has a permanent purchase (ignores trial)
    var hasPurchasedPro: Bool {
        #if DEBUG
        return _debugProEnabled || _purchasedPro || _purchasedSupporter
        #else
        return _purchasedPro || _purchasedSupporter
        #endif
    }

    /// Whether the user's Pro access comes from an active trial (not a purchase)
    var isProViaTrial: Bool {
        !hasPurchasedPro && TrialManager.shared.isTrialActive
    }

    /// Whether the user is a Pet Hero subscriber (debug override OR real purchase)
    var isSupporter: Bool {
        #if DEBUG
        return _debugSupporterEnabled || _purchasedSupporter
        #else
        return _purchasedSupporter
        #endif
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

    private var cancellables = Set<AnyCancellable>()

    private init() {
        // Forward TrialManager changes so views re-render when trial state changes
        TrialManager.shared.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}
