import Foundation
import Security
import SwiftUI

/// Manages the 30-day free Pro trial. Uses Keychain for persistence across app deletions.
class TrialManager: ObservableObject {
    static let shared = TrialManager()

    private let service = "com.pettoxic"
    private let account = "trial.startDate"
    private let trialDurationDays = 30

    @Published private(set) var lastUpdated = Date()

    /// Whether the expiration alert has already been shown
    @AppStorage("trial_expiration_alert_shown") private var expirationAlertShown: Bool = false

    private init() {}

    // MARK: - Trial State

    enum TrialState: Equatable {
        case neverStarted
        case active(daysRemaining: Int)
        case expired
    }

    var trialState: TrialState {
        guard let startDate = readStartDate() else { return .neverStarted }
        let elapsed = Calendar.current.dateComponents([.day], from: startDate, to: Date()).day ?? 0
        let remaining = trialDurationDays - elapsed
        if remaining > 0 {
            return .active(daysRemaining: remaining)
        } else {
            return .expired
        }
    }

    var isTrialActive: Bool {
        if case .active = trialState { return true }
        return false
    }

    var hasTrialExpired: Bool {
        trialState == .expired
    }

    var hasNeverTrialed: Bool {
        trialState == .neverStarted
    }

    var daysRemaining: Int? {
        if case .active(let days) = trialState { return days }
        return nil
    }

    /// True if trial expired and the one-time alert hasn't been shown yet
    var shouldShowExpirationAlert: Bool {
        hasTrialExpired && !expirationAlertShown
    }

    // MARK: - Actions

    func startTrial() {
        writeStartDate(Date())
        objectWillChange.send()
        lastUpdated = Date()
    }

    func markExpirationAlertShown() {
        expirationAlertShown = true
    }

    // MARK: - DEBUG

    #if DEBUG
    func resetTrial() {
        deleteStartDate()
        expirationAlertShown = false
        objectWillChange.send()
        lastUpdated = Date()
    }

    func setExpiringSoon() {
        // 27 days ago → 3 days remaining
        let date = Calendar.current.date(byAdding: .day, value: -27, to: Date())!
        writeStartDate(date)
        objectWillChange.send()
        lastUpdated = Date()
    }

    func setExpired() {
        // 31 days ago → expired
        let date = Calendar.current.date(byAdding: .day, value: -31, to: Date())!
        writeStartDate(date)
        expirationAlertShown = false
        objectWillChange.send()
        lastUpdated = Date()
    }
    #endif

    // MARK: - Keychain

    private func readStartDate() -> Date? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess,
              let data = result as? Data,
              let dateString = String(data: data, encoding: .utf8) else {
            return nil
        }

        let formatter = ISO8601DateFormatter()
        return formatter.date(from: dateString)
    }

    private func writeStartDate(_ date: Date) {
        let formatter = ISO8601DateFormatter()
        let dateString = formatter.string(from: date)
        guard let data = dateString.data(using: .utf8) else { return }

        // Try to update first
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let attributes: [String: Any] = [
            kSecValueData as String: data
        ]

        let updateStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

        if updateStatus == errSecItemNotFound {
            // Add new entry
            var addQuery = query
            addQuery[kSecValueData as String] = data
            addQuery[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
            SecItemAdd(addQuery as CFDictionary, nil)
        }
    }

    private func deleteStartDate() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}
