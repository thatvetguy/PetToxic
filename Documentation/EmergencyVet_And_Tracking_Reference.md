# Emergency Vet & Call Tracking — Implementation Reference

Reference document for porting the My Vet / Emergency Vet and anonymous event tracking features to Pet Toxic: Equine Edition (or other editions).

*Created: 2026-03-19 (Session 162, Pet Toxic main app)*

---

## Feature 1: Per-Pet Vet Address + Maps

### What it does
Adds a `vetAddress` field to the Pet model alongside existing `vetClinicName` and `vetPhone`. Displays an "Open in Maps" button wherever vet info appears.

### Implementation

**Model change:**
- Add `var vetAddress: String?` to the Pet SwiftData model (after `vetPhone`)
- Add to `init()` with default `nil` — SwiftData lightweight migration handles it automatically

**PetFormView:**
- Add `TextField("Vet Address", ...)` after the Vet Phone HStack
- Same optional-string binding pattern as `vetClinicName`
- Inline "Open in Maps" button (blue `map.fill` icon) when address is non-empty
- `.onChange` → `triggerAutoSave()`

**EmergencyPetInfoCard:**
- After the vet phone call button, add address display + blue "Maps" button
- Keep inline styling (don't use EmergencyVetButton here — card has its own density)

**Maps URL:** `http://maps.apple.com/?q=\(encodedAddress)` with `addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)`

---

## Feature 2: Global Emergency Vet (Pro-Only)

### What it does
App-wide emergency vet contact (name, phone, address) stored via UserDefaults singleton. Displayed on the Emergency tab with call and maps buttons. Editable in Settings.

### Architecture decisions
- **Global, not per-pet** — one after-hours clinic serves all pets
- **UserDefaults, not SwiftData** — single record, not a collection
- **Singleton pattern** — matches `AppearanceSettings.swift`

### Files created

**`Services/EmergencyVetSettings.swift`:**
```swift
@MainActor
final class EmergencyVetSettings: ObservableObject {
    static let shared = EmergencyVetSettings()
    @Published var emergencyVetName: String { didSet { UserDefaults... } }
    @Published var emergencyVetPhone: String { didSet { UserDefaults... } }
    @Published var emergencyVetAddress: String { didSet { UserDefaults... } }
    var hasAnyInfo: Bool  // true if any field non-empty
}
```

**`Components/EmergencyVetButton.swift`:**
- Parameters: `name: String?`, `phone: String?`, `address: String?`
- Green-bordered card with call button (green, `tel://`) and maps button (blue, `maps.apple.com`)
- Buttons only render if their field is non-empty
- Used on EmergencyView for global vet display

**`Views/Settings/EmergencyVetFormView.swift`:**
- Form with 3 text fields: Clinic Name, Phone (`.phonePad`), Address
- "Clear All" button when any field has data
- Changes write through immediately via singleton `didSet`

### Integration points

**EmergencyView:**
- New section between EmergencyPetInfoCard and "Contact Poison Control"
- Pro + has info → `EmergencyVetButton`
- Pro + no info → Subtle prompt "Add your emergency vet in Settings"
- Not Pro → Locked placeholder with lock icon + PRO badge

**SettingsView:**
- In "Pro Features" section, after Lab Work Guide
- Pro → `NavigationLink` to `EmergencyVetFormView()`
- Not Pro → Button with upsell alert and PRO badge

---

## Feature 3: Phone Number Auto-Formatting

### What it does
Formats US phone numbers as `(XXX) XXX-XXXX` as the user types. International numbers (starting with `+` or >10 digits) pass through unchanged.

### Implementation
Added `PhoneFormatter` enum to `Utilities/Constants.swift`:

```swift
enum PhoneFormatter {
    static func format(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        if value.hasPrefix("+") || digits.count > 10 { return value }
        switch digits.count {
        case 0: return ""
        case 1...3: return "(\(digits)"
        case 4...6: return "(\(area)) \(mid)"
        case 7...10: return "(\(area)) \(mid)-\(last)"
        default: return value
        }
    }
}
```

Applied via `.onChange` on phone text fields — format, compare, update only if changed (avoids infinite loop).

The `tel://` calls already strip non-digits with `.filter { $0.isNumber }`, so formatting doesn't affect dialing.

---

## Feature 4: Anonymous Event Tracking (Cloudflare Worker + KV)

### What it does
Fire-and-forget anonymous pings to a Cloudflare Worker when users tap poison control call buttons, emergency vet call button, share button, or search with no results.

### What is recorded (and what is NOT)
**Recorded:**
- Event type: `call:aspca`, `call:pph`, `call:emergencyvet`, `share`, `search_miss`
- UTC date (derived server-side)
- Search term (only for `search_miss`, lowercased, max 100 chars)

**NOT recorded:**
- No device ID, user ID, IP address, location, app version, or any personal data

### Cloudflare setup (one-time per app)

1. Create Cloudflare account
2. **Storage & databases** → **KV** → Create namespace (e.g., `equine-call-tracking`)
3. **Compute** → Create Worker → "Start with Hello World!" → name it (e.g., `equine-call-tracker`)
4. Worker **Settings** → **Bindings** → Add KV binding: variable `CALL_TRACKING` → select namespace
5. **Edit Code** → paste worker JS → Deploy

### Worker code
See `CloudflareWorker/worker.js` in the PetToxic repo. Key details:
- `POST /track` — accepts `{"event": "call:aspca"}` etc., increments `total:{event}` and `daily:{event}:{date}` in KV
- `GET /stats?key=SECRET` — returns totals + last 30 days daily breakdown
- `GET /stats?key=SECRET&section=misses` — returns top 50 missed search terms
- `STATS_KEY` constant at top of file = your passphrase for the stats endpoint
- CORS headers allow requests from any origin

### Swift side

**`Services/CallTrackingService.swift`:**
```swift
enum AppTrackingService {
    private static let trackURL = URL(string: "https://YOUR-WORKER.workers.dev/track")!

    static func recordCall(_ buttonId: String) {
        send(["event": "call:\(buttonId)"])
    }
    static func recordShare() {
        send(["event": "share"])
    }
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
```

### Integration points

**PoisonControlButton:**
- Add `trackingId: String` to `EmergencyContact` struct (`"aspca"`, `"pph"`)
- Call `AppTrackingService.recordCall(contact.trackingId)` in `callNumber()` before opening `tel://`

**EmergencyVetButton:**
- Call `AppTrackingService.recordCall("emergencyvet")` before opening `tel://`

**ArticleDetailView:**
- Call `AppTrackingService.recordShare()` when share button is tapped

**SearchViewModel:**
- After `performSearch()` returns empty results, if `query.count >= 3` and not already reported for this term, call `AppTrackingService.recordSearchMiss(term: query)`
- Track `lastMissReported` to avoid duplicate pings for the same term as user types

### Stats URLs (PetToxic main app)
- Main: `https://pet-toxic-call-tracker.cris-af8.workers.dev/stats?key=SASI-2026`
- Misses: `https://pet-toxic-call-tracker.cris-af8.workers.dev/stats?key=SASI-2026&section=misses`

---

## Privacy Policy

Add this section to the privacy policy:

> **Anonymous Usage Signals**
>
> [App Name] sends anonymous, aggregate usage signals to a Cloudflare-hosted service to help us improve the app. These signals include:
> - When a poison control or emergency veterinarian call button is tapped (which button, not the phone number dialed)
> - When the article share button is tapped
> - Search terms that return no results (to help us identify missing entries)
>
> These signals contain no personal information whatsoever — no device identifiers, no IP addresses, no user IDs, no location data, and no account information. Only the event type, the date, and (for failed searches) the search term are recorded.

Also update:
- "Data Stored on Your Device" to mention vet contact info and emergency vet
- "External Links" to mention vet contacts and map actions
- "Last updated" date

---

## Equine Edition Notes

- The Equine app may have different poison control numbers — update `EmergencyContact` static instances and `VALID_EVENTS` in the worker accordingly
- Create a **separate** Cloudflare Worker + KV namespace for the Equine app (don't share with the main app)
- The emergency vet feature may not need Pro gating in Equine if the monetization model differs
- Phone formatter works for US numbers; if Equine targets international users, may need adjustment
