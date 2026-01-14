# Pet Toxic - Data Models

Reference document for data structures used throughout the app.

---

## Primary Entity: ToxicItem

```swift
struct ToxicItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let alternateNames: [String]  // Brand names, synonyms, common misspellings
    let categories: [Category]
    let imageAsset: String?
    let description: String
    let toxicityInfo: String
    let onsetTime: OnsetTime?     // NEW: Timing of symptom onset
    let symptoms: [String]
    let speciesRisks: [SpeciesRisk]
    let sources: [String]
}
```

---

## Supporting Types

### OnsetTime
```swift
struct OnsetTime: Codable {
    let early: String?   // When early symptoms typically appear
    let delayed: String? // When delayed/serious symptoms may develop
}
```

### SpeciesRisk
```swift
struct SpeciesRisk: Codable {
    let species: Species
    let severity: Severity
    let notes: String?
}
```

### SearchResult
```swift
struct SearchResult: Identifiable {
    let id: UUID
    let item: ToxicItem
    let relevanceScore: Double
    let matchType: MatchType  // exact, prefix, fuzzy, synonym
}
```

---

## Enumerations

### Species
```swift
enum Species: String, Codable, CaseIterable {
    case dog
    case cat
    case smallMammal
    case bird
    case reptile
}
```

### Severity
```swift
enum Severity: String, Codable, CaseIterable {
    case low
    case moderate
    case high
    case severe
    
    var color: Color {
        switch self {
        case .low: return .green
        case .moderate: return .yellow
        case .high: return .orange
        case .severe: return .red
        }
    }
}
```

### Category
```swift
enum Category: String, Codable, CaseIterable {
    case foods
    case plants
    case humanMedications
    case cleaningProducts
    case essentialOils
    case garageAutomotive
    case gardenProducts
    case recreationalSubstances
    case holidayHazards
}
```

---

## Emergency Contacts

```swift
struct EmergencyContact {
    let name: String
    let phone: String        // Digits only for tel: URL
    let displayPhone: String // Formatted for display
    let note: String?
}

struct EmergencyContacts {
    static let aspca = EmergencyContact(
        name: "ASPCA Animal Poison Control",
        phone: "8884264435",
        displayPhone: "(888) 426-4435",
        note: "Consultation fee may apply"
    )
    
    static let petPoisonHelpline = EmergencyContact(
        name: "Pet Poison Helpline",
        phone: "8557647661",
        displayPhone: "(855) 764-7661",
        note: "Consultation fee may apply"
    )
}
```

---

## Search Requirements

### Full-Text Search (SQLite FTS5)
- Support prefix matching: "acet" → "acetaminophen"
- Case-insensitive
- Results ranked by relevance

### Fuzzy Matching
- Levenshtein distance for typo tolerance
- "ibuprofin" should match "ibuprofen"
- Max edit distance of 2

### Synonym Support
Maintain synonym table in database:
- "Tylenol" → "acetaminophen"
- "pot", "weed", "marijuana" → "cannabis"
- "raisins" → "grapes"

---

## Database Schema Notes

The SQLite database should include:
1. `toxic_items` — Main content table
2. `toxic_items_fts` — FTS5 virtual table for search
3. `synonyms` — Synonym mapping table
4. `bookmarks` — User bookmarks (local storage)
5. `search_history` — Recent searches (local storage)
