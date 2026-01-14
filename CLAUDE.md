# Pet Toxic - iOS App Development

## Project Overview
Pet Toxic is a native iOS reference app for pet owners to quickly look up toxicity information for substances their pets may have ingested or been exposed to. The app must work offline and never provide medical advice.

## Technical Stack
- **Language:** Swift 5.9+
- **UI Framework:** SwiftUI (primary)
- **Minimum iOS:** 16.0
- **Architecture:** MVVM (Model-View-ViewModel)
- **Database:** SQLite with FTS5 for full-text search
- **Version Control:** GitHub
- **Dependencies:** Minimize external dependencies; prefer native frameworks

## Core Principles

### 1. OFFLINE FIRST
All toxicity data must be bundled with the app and work without internet connection. Users may be in rural areas or emergency situations without connectivity.

### 2. NO MEDICAL ADVICE
This is critical for legal compliance. Never provide:
- Dosage or "safe amount" calculations
- Instructions for inducing vomiting
- Home treatment recommendations
- Prognosis or survival rate information
- Specific medication recommendations

### 3. ALWAYS DISCLAIM
Every article view must prominently display the legal disclaimer. The disclaimer must be visible without scrolling.

### 4. SPEED
Users may be panicked. Information must be accessible within 2-3 taps from app launch. Prioritize fast search and clear navigation.

### 5. ACCESSIBILITY
- Support Dynamic Type (scalable text)
- Full VoiceOver support
- High contrast mode compatibility
- Minimum 44pt touch targets

---

## GitHub Workflow

### Repository Structure
```
PetToxic/
├── PetToxic/              # Main Xcode project
├── PetToxicTests/         # Unit tests
├── PetToxicUITests/       # UI tests
├── Resources/
│   └── ToxicityData/      # JSON content files
├── Documentation/
│   ├── Design/            # Design document, wireframes
│   └── Content/           # Article drafts, sources
├── .gitignore
├── README.md
├── CLAUDE.md              # This file
└── LICENSE
```

### Branch Strategy
- `main` — Stable, release-ready code only
- `develop` — Active development branch
- `feature/[name]` — Individual features (e.g., `feature/search-ui`)
- `content/[name]` — Content additions (e.g., `content/medications-batch1`)

### Commit Messages
Use clear, descriptive commit messages:
- `feat: Add search functionality with fuzzy matching`
- `fix: Correct severity color for moderate level`
- `content: Add 25 food toxicity entries`
- `docs: Update README with setup instructions`

### .gitignore Essentials
```
# Xcode
*.xcuserstate
xcuserdata/
DerivedData/
*.xcworkspace (if using CocoaPods)

# macOS
.DS_Store

# Swift Package Manager
.build/
.swiftpm/

# Sensitive
*.p12
*.mobileprovision
```

---

## Data Model

### ToxicItem (Primary Entity)
```swift
struct ToxicItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let alternateNames: [String]  // Brand names, synonyms, common misspellings
    let categories: [Category]
    let imageAsset: String?
    let description: String
    let toxicityInfo: String
    let symptoms: [String]
    let speciesRisks: [SpeciesRisk]
    let sources: [String]
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

### Enumerations
```swift
enum Species: String, Codable, CaseIterable {
    case dog, cat, smallMammal, bird, reptile
}

enum Severity: String, Codable, CaseIterable {
    case low, moderate, high, severe
    
    var color: Color {
        switch self {
        case .low: return .green
        case .moderate: return .yellow
        case .high: return .orange
        case .severe: return .red
        }
    }
}

enum Category: String, Codable, CaseIterable {
    case foods, plants, humanMedications, cleaningProducts
    case essentialOils, garageAutomotive, gardenProducts
    case recreationalSubstances, holidayHazards
}
```

---

## Search Requirements

### Full-Text Search
- Use SQLite FTS5 for efficient full-text search
- Support prefix matching: "acet" → "acetaminophen"
- Case-insensitive matching
- Results ranked by relevance

### Fuzzy Matching
- Implement Levenshtein distance for typo tolerance
- "ibuprofin" should match "ibuprofen"
- Max edit distance of 2 for reasonable matches

### Synonym Support
- Maintain synonym table in database
- "Tylenol" → "acetaminophen"
- "pot", "weed", "marijuana" → "cannabis"
- "raisins" → "grapes"

---

## UI Structure

### Tab Navigation
1. **Search** (Home) - Primary search with species filter
2. **Browse** - Category grid navigation
3. **Saved** - Bookmarks and search history
4. **Emergency** - Poison control quick-dial

### Key Screens

#### Search Screen
- Large search bar at top (always visible)
- Species filter chips below search bar
- Recent searches when search is empty
- Results list with severity indicators

#### Article Detail Screen
- Item image at top
- Name + severity badge
- Species-specific risk levels
- "What is it?" section
- "Why is it toxic?" section
- "Symptoms to watch for" list
- **Disclaimer box (prominent, always visible)**
- Poison control call buttons
- Bookmark button in nav bar

#### Emergency Screen
- Large tap-to-call buttons
- ASPCA: (888) 426-4435
- Pet Poison Helpline: (855) 764-7661
- Note about consultation fees
- Tips for what info to have ready

---

## Required Disclaimer Text

Display this on EVERY article page:

> **DISCLAIMER:** This information is for educational purposes only and does not constitute veterinary medical advice. If your pet has been exposed to a potentially toxic substance, contact a licensed veterinarian or animal poison control center immediately.

---

## Visual Design

### Colors
- **Primary:** Teal (#4A9B9B)
- **Background:** Light gray (#F8F9FA)
- **Text:** Dark gray (#333333)
- **Severity:**
  - Low: Green (#90EE90)
  - Moderate: Yellow (#FFD700)
  - High: Orange (#FFA500)
  - Severe: Red (#FF4444)

### Typography
- Use system fonts (SF Pro)
- Body text: 16pt minimum
- Clear hierarchy between headlines, body, and captions

### Icons
- SF Symbols for system consistency
- Custom icons for categories if needed

---

## File Structure (Xcode Project)

```
PetToxic/
├── App/
│   └── PetToxicApp.swift
├── Models/
│   ├── ToxicItem.swift
│   ├── SpeciesRisk.swift
│   ├── Enums.swift
│   └── SearchResult.swift
├── ViewModels/
│   ├── SearchViewModel.swift
│   ├── BrowseViewModel.swift
│   ├── ArticleViewModel.swift
│   └── SavedViewModel.swift
├── Views/
│   ├── MainTabView.swift
│   ├── Search/
│   │   ├── SearchView.swift
│   │   ├── SearchResultRow.swift
│   │   └── SpeciesFilterView.swift
│   ├── Browse/
│   │   ├── BrowseView.swift
│   │   └── CategoryGridItem.swift
│   ├── Article/
│   │   ├── ArticleDetailView.swift
│   │   ├── SeveritySection.swift
│   │   └── SymptomsListView.swift
│   ├── Saved/
│   │   ├── SavedView.swift
│   │   ├── BookmarksListView.swift
│   │   └── HistoryListView.swift
│   └── Emergency/
│       └── EmergencyView.swift
├── Services/
│   ├── DatabaseService.swift
│   ├── SearchService.swift
│   └── BookmarkService.swift
├── Components/
│   ├── SeverityBadge.swift
│   ├── DisclaimerView.swift
│   ├── PoisonControlButton.swift
│   └── LoadingView.swift
├── Resources/
│   ├── ToxicityDatabase.sqlite
│   ├── Assets.xcassets/
│   └── Localizable.strings
└── Utilities/
    ├── Extensions/
    └── Constants.swift
```

---

## Code Style Guidelines

### Naming
- camelCase for variables and functions
- PascalCase for types (structs, classes, enums)
- Descriptive names over abbreviations

### SwiftUI Best Practices
- Keep views small and composable
- Extract reusable components
- Use `@Observable` (iOS 17+) or `@ObservableObject` for view models
- Prefer `@State` for view-local state
- Use `@Environment` for dependency injection

### Error Handling
- Use Swift's native error handling
- Provide user-friendly error messages
- Log errors for debugging (but don't expose to users)

### Comments
- Comment complex business logic
- Avoid obvious comments
- Use `// MARK:` for code organization

---

## Testing Requirements

### Unit Tests
- Search logic (fuzzy matching, synonyms)
- Data model parsing
- Filter functionality
- Bookmark/history persistence

### UI Tests
- Search flow (type → results → detail)
- Category browsing
- Bookmark add/remove
- Emergency call buttons

### Manual Testing
- Offline functionality
- VoiceOver navigation
- Dynamic Type scaling
- Different device sizes (iPhone SE through Pro Max)

---

## What NOT to Include

❌ Dosage or "safe amount" calculations  
❌ Instructions for inducing vomiting  
❌ Home treatment recommendations  
❌ Prognosis information  
❌ User accounts or sign-in  
❌ Cloud sync  
❌ Advertisements  
❌ Analytics tracking (beyond basic App Store analytics)  
❌ In-app purchases (v1.0)  

---

## Emergency Contacts (Hardcoded)

```swift
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

## Development Phases

### Phase 1: Foundation
- Project setup with SwiftUI
- Initialize GitHub repository
- Data models and database schema
- Basic tab navigation
- Core search functionality

### Phase 2: Features
- Article detail view with all sections
- Category browsing
- Bookmarks and history
- Emergency contacts screen

### Phase 3: Content & Polish
- Populate 200-300 toxicity entries
- UI refinement
- Accessibility testing
- Performance optimization

### Phase 4: Launch
- Legal review
- App Store assets
- TestFlight beta
- App Store submission

---

## Questions to Ask Before Coding

When starting a new feature, clarify:
1. Does this feature work offline?
2. Could this be construed as medical advice?
3. Is the disclaimer visible?
4. Does it meet accessibility requirements?
5. Is the code testable?
6. Have changes been committed to the appropriate branch?
