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
    let onsetTime: OnsetTime?     // Timing of symptom onset
    let symptoms: [String]
    let speciesRisks: [SpeciesRisk]
    let preventionTips: [String]? // NEW: Optional tips to prevent exposure
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
    
    var displayName: String {
        switch self {
        case .low: return "Low"
        case .moderate: return "Moderate"
        case .high: return "High"
        case .severe: return "Severe"
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
    case garageGarden
    case gardenProducts
    case recreationalSubstances
    case holidayHazards

    var displayName: String {
        switch self {
        case .foods: return "Foods"
        case .plants: return "Plants"
        case .humanMedications: return "Human Medications"
        case .cleaningProducts: return "Cleaning Products"
        case .essentialOils: return "Essential Oils"
        case .garageGarden: return "Garage & Garden"
        case .gardenProducts: return "Garden Products"
        case .recreationalSubstances: return "Recreational Substances"
        case .holidayHazards: return "Holiday Hazards"
        }
    }

    var iconName: String {
        switch self {
        case .foods: return "fork.knife"
        case .plants: return "leaf"
        case .humanMedications: return "pills"
        case .cleaningProducts: return "bubbles.and.sparkles"
        case .essentialOils: return "drop"
        case .garageGarden: return "car"
        case .gardenProducts: return "shovel"
        case .recreationalSubstances: return "exclamationmark.triangle"
        case .holidayHazards: return "gift"
        }
    }
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
    
    static let all: [EmergencyContact] = [aspca, petPoisonHelpline]
}
```

---

## User Data Models

### Bookmark
```swift
struct Bookmark: Identifiable, Codable {
    let id: UUID
    let itemId: UUID       // Reference to ToxicItem
    let dateAdded: Date
}
```

### SearchHistoryEntry
```swift
struct SearchHistoryEntry: Identifiable, Codable {
    let id: UUID
    let query: String
    let timestamp: Date
    let resultCount: Int?
}
```

### ViewHistoryEntry
```swift
struct ViewHistoryEntry: Identifiable, Codable {
    let id: UUID
    let itemId: UUID       // Reference to ToxicItem
    let timestamp: Date
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
6. `view_history` — Recently viewed items (local storage)

---

## Sample JSON Entry

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "name": "Chocolate",
  "alternateNames": ["cocoa", "cacao", "dark chocolate", "milk chocolate", "baking chocolate"],
  "categories": ["foods", "holidayHazards"],
  "imageAsset": "chocolate",
  "description": "Chocolate is a food product made from roasted cacao beans, commonly found in candy, baked goods, and beverages.",
  "toxicityInfo": "Chocolate contains theobromine and caffeine, both methylxanthines that dogs and cats cannot metabolize efficiently. Dark chocolate and baking chocolate contain higher concentrations and pose greater risk.",
  "onsetTime": {
    "early": "Vomiting and restlessness may appear within 1-2 hours",
    "delayed": "Cardiac and neurological signs may develop 6-12 hours after ingestion"
  },
  "symptoms": [
    "Vomiting",
    "Diarrhea",
    "Increased thirst and urination",
    "Restlessness or hyperactivity",
    "Rapid breathing",
    "Muscle tremors",
    "Seizures (in severe cases)"
  ],
  "speciesRisks": [
    {
      "species": "dog",
      "severity": "high",
      "notes": "Dogs are particularly sensitive to theobromine"
    },
    {
      "species": "cat",
      "severity": "severe",
      "notes": "Cats rarely consume chocolate but are equally sensitive"
    }
  ],
  "preventionTips": [
    "Store all chocolate products in closed cabinets out of pet reach",
    "Be especially vigilant during holidays when chocolate is abundant",
    "Educate children not to share chocolate with pets",
    "Remember that baking chocolate and dark chocolate are most dangerous"
  ],
  "sources": [
    "ASPCA Animal Poison Control Center",
    "Merck Veterinary Manual",
    "Pet Poison Helpline"
  ]
}
```
