import Foundation

/// Fire-and-forget anonymous event tracking via Cloudflare Worker.
/// No personal data is collected — only event type, date, and optional search term.
/// Silently fails if offline or the request errors.
enum AppTrackingService {
    private static let trackURL = URL(string: "https://pet-toxic-call-tracker.cris-af8.workers.dev/track")!

    /// Record a poison control or emergency vet call tap.
    static func recordCall(_ buttonId: String) {
        send(["event": "call:\(buttonId)"])
    }

    /// Record an article share tap.
    static func recordShare() {
        send(["event": "share"])
    }

    /// Record a generic event by name (sent as-is, no prefix).
    static func recordEvent(_ event: String) {
        send(["event": event])
    }

    /// Record a search that returned zero results.
    static func recordSearchMiss(term: String) {
        send(["event": "search_miss", "term": term])
    }

    private static func send(_ body: [String: String]) {
        var request = URLRequest(url: trackURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        request.timeoutInterval = 5

        URLSession.shared.dataTask(with: request) { _, _, _ in }.resume()
    }
}

// Legacy name alias — existing code uses CallTrackingService.recordTap
enum CallTrackingService {
    static func recordTap(button: String) {
        AppTrackingService.recordCall(button)
    }
}
