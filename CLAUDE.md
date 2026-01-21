# Pet Toxic - iOS App

## Overview
Native iOS reference app for pet owners to quickly look up toxicity information. Works offline. Never provides medical advice.

## Technical Stack
- **Language:** Swift 5.9+
- **UI:** SwiftUI
- **iOS Target:** 16.0+
- **Architecture:** MVVM
- **Database:** SQLite with FTS5 for search
- **Dependencies:** Minimize; prefer native frameworks

## Core Principles

### 1. OFFLINE FIRST
All data bundled with app. Users may be in emergencies without connectivity.

### 2. NO MEDICAL ADVICE
Never provide: dosage calculations, inducing vomiting instructions, home treatments, prognosis, medication recommendations.

### 3. ALWAYS DISCLAIM
Every article view must display the legal disclaimer prominently, visible without scrolling.

### 4. SPEED
Information accessible within 2-3 taps. Users may be panicked.

### 5. ACCESSIBILITY
Dynamic Type, VoiceOver, high contrast, 44pt minimum touch targets.

## Key Constraints

**Do NOT include:**
- Dosage or "safe amount" calculations
- Treatment instructions of any kind
- User accounts or cloud sync
- Advertisements or analytics tracking
- In-app purchases (v1.0)

## Branch Strategy
- `main` — Stable, release-ready only
- `develop` — Active development
- `feature/[name]` — Individual features
- `content/[name]` — Content additions

## Commit Format
- `feat:` New features
- `fix:` Bug fixes
- `content:` Toxicity data additions
- `docs:` Documentation updates

## Plan Mode
- Keep plans concise. Sacrifice grammar for brevity.
- End each plan with unresolved questions, if any.

## Reference Documents
- **Data Models:** Documentation/DataModels.md
- **UI Spec:** Documentation/Design/UI-Spec.md
- **Style Guide:** Documentation/Design/StyleGuide.md

## Questions Before Coding
1. Does this feature work offline?
2. Could this be construed as medical advice?
3. Is the disclaimer visible?
4. Does it meet accessibility requirements?
5. Is the code testable?
6. Correct branch?

## Project Structure

```
PetToxic/
├── PetToxic/
│   ├── App/
│   │   └── PetToxicApp.swift          # App entry point
│   ├── Components/                     # Reusable UI components
│   │   ├── DisclaimerView.swift       # Legal disclaimer banner
│   │   ├── EmptyStateView.swift
│   │   ├── LoadingView.swift
│   │   ├── PoisonControlButton.swift  # Emergency call buttons
│   │   ├── RelatedEntryButton.swift
│   │   └── SeverityBadge.swift        # Toxicity level indicator
│   ├── Models/
│   │   ├── Enums.swift                # Species, Severity, Category, MatchType
│   │   ├── SearchResult.swift
│   │   ├── SpeciesRisk.swift
│   │   └── ToxicItem.swift            # Main toxin data model
│   ├── Resources/
│   │   ├── Assets.xcassets/           # App icons, colors, images
│   │   ├── Info.plist
│   │   └── LaunchScreen.storyboard
│   ├── Services/
│   │   ├── AppearanceSettings.swift   # Dark/light mode (default: dark)
│   │   ├── BookmarkService.swift      # Save favorites
│   │   ├── DatabaseService.swift      # Toxin data (hardcoded, SQLite planned)
│   │   └── SearchService.swift        # FTS5 search
│   ├── Utilities/
│   │   ├── Constants.swift
│   │   └── Extensions/
│   │       └── Color+Hex.swift
│   ├── ViewModels/
│   │   ├── ArticleViewModel.swift
│   │   ├── BrowseViewModel.swift
│   │   ├── SavedViewModel.swift
│   │   └── SearchViewModel.swift
│   └── Views/
│       ├── MainTabView.swift          # Tab bar controller
│       ├── Article/
│       │   ├── ArticleDetailView.swift # Toxin detail page + share
│       │   ├── SeveritySection.swift
│       │   └── SymptomsListView.swift
│       ├── Browse/
│       │   ├── BrowseView.swift
│       │   └── CategoryGridItem.swift
│       ├── Emergency/
│       │   └── EmergencyView.swift    # Poison control contacts
│       ├── Saved/
│       │   ├── BookmarksListView.swift
│       │   ├── HistoryListView.swift
│       │   └── SavedView.swift
│       ├── Search/
│       │   ├── SearchResultRow.swift
│       │   ├── SearchView.swift
│       │   └── SpeciesFilterView.swift
│       └── Settings/
│           └── SettingsView.swift     # Appearance toggle
├── PetToxicTests/
│   └── PetToxicTests.swift
├── PetToxicUITests/
│   └── PetToxicUITests.swift
├── Documentation/
│   ├── DataModels.md
│   ├── DesignDocument.md
│   └── Design/
│       ├── StyleGuide.md
│       └── UI-Spec.md
└── CLAUDE.md
```

## Common File Locations

| Task | File(s) |
|------|---------|
| Add new toxin entry | `Services/DatabaseService.swift` |
| Modify toxin data model | `Models/ToxicItem.swift`, `Models/SpeciesRisk.swift` |
| Change severity levels/colors | `Models/Enums.swift` (Severity enum) |
| Add new category | `Models/Enums.swift` (Category enum) |
| Modify article display | `Views/Article/ArticleDetailView.swift` |
| Change share text format | `Views/Article/ArticleDetailView.swift` (generateShareText) |
| Update disclaimer text | `Components/DisclaimerView.swift` |
| Modify search behavior | `Services/SearchService.swift` |
| Change default appearance | `Services/AppearanceSettings.swift` |
| Add new tab | `Views/MainTabView.swift` |
| Emergency contacts | `Components/PoisonControlButton.swift` |
