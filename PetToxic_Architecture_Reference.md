# PetToxic Architecture Reference

> Generated from live codebase — February 2026

---

## Tech Stack

| Component | Technology |
|-----------|------------|
| Language | Swift 5.9+ |
| UI | SwiftUI |
| iOS Target | 17.6+ |
| Architecture | MVVM |
| Persistence | SwiftData (Pet profiles), UserDefaults (bookmarks, history, preferences) |
| Search | In-memory string matching (name + alternateNames) |
| IAP | StoreKit 2 |
| Dependencies | None — 100% native frameworks |

---

## Project Structure

```
PetToxic/
├── PetToxic/
│   ├── App/
│   │   └── PetToxicApp.swift              # @main entry point
│   ├── Components/                         # 22 reusable UI components
│   │   ├── AddCaseNumberField.swift
│   │   ├── AppBackground.swift            # Teal gradient background
│   │   ├── CaseNumberRow.swift
│   │   ├── DisclaimerPopupView.swift      # Version-gated launch disclaimer
│   │   ├── DisclaimerView.swift           # Collapsible in-article disclaimer
│   │   ├── EmergencyPetInfoCard.swift     # Pet info for Emergency tab (Pro)
│   │   ├── EmptyStateView.swift
│   │   ├── GlossaryCard.swift             # Glossary promo card (Pro gate)
│   │   ├── GlossaryDropdownView.swift     # Collapsible glossary terms in articles
│   │   ├── GlossaryEntryLink.swift        # Link to glossary from articles
│   │   ├── GlossaryStyledText.swift       # Markdown + glossary + search highlighting
│   │   ├── HighlightableMarkdownText.swift # Markdown + search highlighting
│   │   ├── HomeHeader.swift               # App logo header
│   │   ├── LoadingView.swift
│   │   ├── MarkdownText.swift             # Simple markdown renderer
│   │   ├── MyPetsPlaceholder.swift        # My Pets upsell card
│   │   ├── PetAvatarView.swift            # Circular pet photo
│   │   ├── PoisonControlButton.swift      # Emergency call buttons
│   │   ├── RelatedEntryButton.swift
│   │   ├── SeverityBadge.swift            # Colored toxicity level pill
│   │   └── ShareCardView.swift            # 1024x1024 share image renderer
│   ├── Models/                             # 13 model files
│   │   ├── Enums.swift                    # Species, Severity, Category, MatchType
│   │   ├── GlossaryTerm.swift             # GlossaryTerm + GlossaryCategory
│   │   ├── LabCategory.swift              # Lab subcategories (15 cases)
│   │   ├── LabPanelType.swift             # CBC, Chemistry, Coagulation, etc.
│   │   ├── LabParameter.swift             # Lab test parameter model
│   │   ├── NavigationContext.swift        # CategoryEntry + BrowseNavigationContext
│   │   ├── Pet.swift                      # SwiftData @Model for pet profiles
│   │   ├── PetSex.swift                   # Male/Female/Neutered/Spayed
│   │   ├── PetSpecies.swift               # 35+ specific species + PetSpeciesCategory
│   │   ├── PoisonControlCase.swift        # SwiftData @Model for case numbers
│   │   ├── SearchResult.swift
│   │   ├── SpeciesRisk.swift
│   │   └── ToxicItem.swift                # Core toxin entry model
│   ├── Resources/
│   │   ├── Assets.xcassets/               # Icons, colors, thumbnail images
│   │   ├── breeds.json                    # Breed autocomplete data
│   │   ├── Info.plist
│   │   └── LaunchScreen.storyboard
│   ├── Services/                           # 11 service files
│   │   ├── AppearanceSettings.swift       # Dark/light mode
│   │   ├── BookmarkService.swift          # Favorites + view history
│   │   ├── BreedService.swift             # Breed autocomplete from breeds.json
│   │   ├── BrowseFilterService.swift      # Species filter for Browse tab
│   │   ├── DatabaseService.swift          # ~170 hardcoded ToxicItem entries (~14K lines)
│   │   ├── GlossaryService.swift          # ~213 hardcoded GlossaryTerm entries
│   │   ├── LabWorkGuideService.swift      # ~63 hardcoded LabParameter entries
│   │   ├── PetPhotoService.swift          # Photo save/load/delete (Documents dir)
│   │   ├── PetStore.swift                 # SwiftData CRUD for Pet model
│   │   ├── ProSettings.swift              # IAP entitlement state
│   │   └── StoreKitService.swift          # StoreKit 2 purchase/restore
│   │   └── SearchService.swift            # Search ranking + relevance scoring
│   ├── Utilities/
│   │   ├── Constants.swift                # AppColors, AppSpacing, AppLayout, AppShare
│   │   └── Extensions/
│   │       ├── Color+Hex.swift            # Color(hex: "FF4444")
│   │       └── Font+Poppins.swift         # Poppins font with system fallback
│   ├── ViewModels/
│   │   ├── ArticleViewModel.swift         # Bookmark toggle + history recording
│   │   ├── BrowseViewModel.swift          # Category → items mapping
│   │   ├── SavedViewModel.swift           # Bookmarks + history + recent searches
│   │   └── SearchViewModel.swift          # Debounced search + SearchContext singleton
│   └── Views/
│       ├── MainTabView.swift              # 5-tab root with swipe gestures
│       ├── Article/
│       │   ├── ArticleDetailView.swift    # Toxin detail page
│       │   ├── SeveritySection.swift      # Species risk display
│       │   └── SymptomsListView.swift     # Bulleted symptom list
│       ├── Browse/
│       │   ├── BrowseView.swift           # Category grid + CategoryListView + EntryListRow
│       │   └── CategoryGridItem.swift     # Category tile
│       ├── Components/
│       │   └── MyPetsHomeSection.swift    # Pet carousel for Home tab
│       ├── Emergency/
│       │   └── EmergencyView.swift        # Poison control contacts + pet info
│       ├── Glossary/
│       │   ├── GlossaryView.swift         # A-Z glossary browser (Pro)
│       │   └── GlossaryTermDetailView.swift
│       ├── LabWorkGuide/
│       │   ├── LabWorkGuideView.swift     # Lab parameter browser (Pro)
│       │   ├── LabParameterDetailView.swift
│       │   ├── LabWorkGuideCard.swift     # Promo card
│       │   └── LabWorkGuideSourcesView.swift
│       ├── MyPets/
│       │   ├── PetListView.swift          # Pet profile list (Pro)
│       │   ├── PetFormView.swift          # Add/edit pet profile
│       │   └── PetPhotoPickerView.swift   # Photo selection
│       ├── Saved/
│       │   ├── SavedView.swift            # Bookmarks + History tabs
│       │   ├── BookmarksListView.swift
│       │   └── HistoryListView.swift
│       ├── Search/
│       │   ├── SearchView.swift           # Home tab (search + cards)
│       │   ├── SearchResultRow.swift
│       │   └── SpeciesFilterView.swift
│       └── Settings/
│           ├── SettingsView.swift         # Settings + about + IAP
│           └── UpgradeView.swift          # IAP product selection
```

**File counts:** 79 Swift files, ~14,000 lines in DatabaseService alone.

---

## Data Models

### ToxicItem (Core Entry Model)

The central data model representing a single toxic substance entry.

| Field | Type | Notes |
|-------|------|-------|
| `id` | `UUID` | Stable identifier; never change |
| `name` | `String` | Primary display name |
| `alternateNames` | `[String]` | Synonyms, misspellings, brand names — used for search |
| `categories` | `[Category]` | Can appear in multiple categories |
| `imageAsset` | `String?` | Asset catalog name for thumbnail |
| `description` | `String` | What the substance is (plain language) |
| `toxicityInfo` | `String` | Why it's toxic and how it affects pets |
| `onsetTime` | `OnsetTime?` | Early vs delayed symptom timing |
| `symptoms` | `[String]` | Observable signs |
| `entrySeverity` | `Severity?` | Overall severity; `nil` for informational entries |
| `speciesRisks` | `[SpeciesRisk]` | Per-species severity + notes (must include all 5 species) |
| `preventionTips` | `[String]?` | How to prevent exposure |
| `sources` | `[String]` | Min 3 publicly accessible sources |
| `relatedEntries` | `[String]?` | UUID strings for cross-references (bidirectional) |

**Conformances:** `Identifiable`, `Codable`, `Hashable` (hashes on `id` only)

### OnsetTime

| Field | Type |
|-------|------|
| `early` | `String?` |
| `delayed` | `String?` |

### SpeciesRisk

| Field | Type |
|-------|------|
| `species` | `Species` |
| `severity` | `Severity` |
| `notes` | `String?` |

**Conformances:** `Codable`, `Hashable`, `Identifiable` (id = species.rawValue)

### SearchResult

| Field | Type |
|-------|------|
| `id` | `UUID` (= item.id) |
| `item` | `ToxicItem` |
| `relevanceScore` | `Double` |
| `matchType` | `MatchType` |

### GlossaryTerm

| Field | Type |
|-------|------|
| `id` | `UUID` |
| `term` | `String` |
| `pronunciation` | `String?` |
| `definition` | `String` (supports markdown) |
| `category` | `GlossaryCategory` |
| `relatedTerms` | `[String]?` (term names) |
| `searchKeywords` | `[String]?` |

### LabParameter

| Field | Type |
|-------|------|
| `id` | `UUID` |
| `name` | `String` |
| `abbreviation` | `String` |
| `alternateAbbreviations` | `[String]?` |
| `category` | `LabCategory` |
| `panelType` | `LabPanelType` |
| `whatItMeasures` | `String` |
| `highMeaning` | `String` |
| `lowMeaning` | `String?` |
| `speciesNotes` | `String?` |
| `relatedGlossaryTerms` | `[String]?` |
| `searchKeywords` | `[String]?` |

### Pet (@Model — SwiftData)

| Field | Type | Notes |
|-------|------|-------|
| `id` | `UUID` | |
| `name` | `String` | |
| `nickname` | `String?` | |
| `species` | `String` | Raw value → `PetSpecies` enum |
| `breed` | `String?` | |
| `sex` | `String` | Raw value → `PetSex` enum |
| `weightLbs` | `Double?` | |
| `birthday` | `Date?` | |
| `isBirthdayApproximate` | `Bool` | |
| `photoFilename` | `String?` | |
| `microchipNumber` | `String?` | |
| `vetClinicName` | `String?` | |
| `vetPhone` | `String?` | |
| `notes` | `String?` | |
| `dateCreated` | `Date` | |
| `dateModified` | `Date` | |
| `sortOrder` | `Int` | Drag-to-reorder support |
| `prioritizeInBrowse` | `Bool` | Auto-filter species in Browse |
| `poisonControlCases` | `[PoisonControlCase]` | @Relationship, cascade delete |

**Computed:** `speciesEnum`, `sexEnum`, `weightKg`, `weightDisplayString`, `age`, `ageDisplayString`

### PoisonControlCase (@Model — SwiftData)

| Field | Type |
|-------|------|
| `id` | `UUID` |
| `caseNumber` | `String` |
| `dateAdded` | `Date` |
| `note` | `String?` |
| `pet` | `Pet?` |

---

## Enums

### Species
Cases: `.dog`, `.cat`, `.smallMammal`, `.bird`, `.reptile`
- Display names: Dogs, Cats, Small Mammals, Birds, Reptiles
- Icons: `dog`, `cat`, `hare`, `bird`, `lizard`
- Comparable (sorted in listed order)

### Severity
Cases: `.low`, `.lowModerate`, `.moderate`, `.high`, `.severe`
- Colors: Green → Yellow → Gold → Orange → Red
- Comparable (low=1 through severe=5)

### Category
Cases: `.foods`, `.plants`, `.medications`, `.cleaningProducts`, `.garageGarden`, `.recreationalSubstances`, `.holidayHazards`, `.householdItems`, `.outdoorHazards`, `.informational`
- 10 total categories
- Icons: `fork.knife`, `leaf.fill`, `pills.fill`, `bubbles.and.sparkles`, `wrench.and.screwdriver.fill`, `smoke.fill`, `gift.fill`, `house.fill`, `figure.hiking`, `info.circle.fill`

### MatchType
Cases: `.exact`, `.prefix`, `.fuzzy`, `.synonym`

### GlossaryCategory
Cases: `.symptoms`, `.conditions`, `.mechanisms`, `.anatomy`, `.treatment`, `.medications`, `.general`

### LabPanelType
Cases: `.cbc`, `.chemistry`, `.coagulation`, `.pancreas`, `.urinalysis`

### LabCategory
15 subcategories mapped to parent panels (e.g., `.redBloodCells` → `.cbc`, `.kidneyValues` → `.chemistry`)

### PetSpecies
35+ cases grouped into: Dogs & Cats, Small Mammals (11), Birds (11), Reptiles (10)

### PetSex
Cases: `.male`, `.maleNeutered`, `.female`, `.femaleSpayed`

### SpeciesFilter (Browse-only)
Cases: `.auto`, `.all`, `.specific(Species)`, `.informational`

---

## Services

### DatabaseService
**Singleton:** `DatabaseService.shared`

Stores all ~170 ToxicItem entries as a hardcoded Swift array (~14,000 lines). Initialized once at app launch.

| Method | Returns | Purpose |
|--------|---------|---------|
| `items(for: Category)` | `[ToxicItem]` | Filter entries by category |
| `item(withId: UUID)` | `ToxicItem?` | Look up by UUID |
| `item(withIdString: String)` | `ToxicItem?` | Look up by UUID string |
| `search(query:species:)` | `[ToxicItem]` | In-memory search on name + alternateNames, optional species filter |

**Search implementation:** Case-insensitive `contains` matching on `name` and `alternateNames`. No FTS5 yet (planned for SQLite migration).

### SearchService
Wraps `DatabaseService.search()` with relevance scoring and match type classification.

**Scoring:** Base score (100 - position index) + bonuses: exact name match (+50), prefix match (+25), alternate name match (+10).

**Match types:** exact → prefix → synonym → fuzzy.

### BookmarkService
**Singleton:** `BookmarkService.shared`

| Property | Type | Storage |
|----------|------|---------|
| `bookmarks` | `[ToxicItem]` | UserDefaults (UUID array) |
| `history` | `[ToxicItem]` | UserDefaults (UUID array, max 50) |

Methods: `isBookmarked`, `addBookmark`, `removeBookmark`, `addToHistory`, `clearHistory`.

### GlossaryService
**Singleton:** `GlossaryService.shared`

~213 hardcoded `GlossaryTerm` entries. Provides alphabetical sorting, letter grouping, category filtering, and text search (term name + definition + keywords).

### LabWorkGuideService
**Singleton:** `LabWorkGuideService.shared`

~63 hardcoded `LabParameter` entries across 5 panels (CBC: 18, Chemistry: 24, Coagulation: 4, Pancreas: 2, Urinalysis: 15).

### AppearanceSettings
**Singleton:** `AppearanceSettings.shared`

Three modes: System, Light, Dark. Default: Dark. Persisted to UserDefaults.

*Note: PetToxicApp forces `.preferredColorScheme(.dark)` at the scene level, so this setting is not actively exposed in UI.*

### ProSettings
**Singleton:** `ProSettings.shared`

Manages IAP entitlement state. Two boolean flags cached in `@AppStorage`:
- `isPro` — true if Pro purchased OR Supporter purchased
- `isSupporter` — true if Supporter (Pet Hero) purchased

Debug overrides available in DEBUG builds (toggled via hidden Developer Options in Settings).

### StoreKitService
**Singleton:** `StoreKitService.shared`

StoreKit 2 implementation with two non-consumable products:
- `com.pettoxic.pro1` — Pro tier
- `com.pettoxic.supporter1` — Pet Hero tier

Handles: product loading, purchase flow, restore, entitlement verification on launch, transaction listener for updates.

### BrowseFilterService
Static utility class. Converts `PetSpecies` (35+ granular) to `Species` (5 broad categories) and filters entries based on user's pet profiles.

Key logic: entries whose `speciesRisks` don't include a filtered species are **included** (safety-first — unknown = potentially dangerous).

### PetStore
**@Observable** class requiring `ModelContext` injection.

SwiftData CRUD for Pet model. Max 5 pets. Supports reordering via `sortOrder`.

### PetPhotoService
**Singleton:** `PetPhotoService.shared`

Saves pet photos to `Documents/pet_photos/` as JPEG. Resizes to max 800x800, compresses to under 500KB.

### BreedService
**Singleton:** `BreedService.shared`

Loads breed data from bundled `breeds.json`. Provides fuzzy search with alias matching. Generates mix breed names (e.g., "Labrador Mix").

---

## View Architecture

### Tab Structure (MainTabView)

| Index | Tab | Icon | View |
|-------|-----|------|------|
| 0 | Home | `house.fill` | SearchView |
| 1 | Browse | `square.grid.2x2.fill` | BrowseView |
| 2 | Saved | `bookmark.fill` | SavedView |
| 3 | Emergency | `phone.fill` | EmergencyView |
| 4 | Settings | `gearshape.fill` | SettingsView |

**Custom tab bar** — not SwiftUI TabView. Manual HStack with buttons. Tab bar hides when keyboard is visible.

### Navigation Patterns

**Browse tab** uses `NavigationStack` with `NavigationPath` binding. Three navigation destinations registered at root:
1. `Category` → `CategoryListView`
2. `ToxicItem` → `ArticleDetailView` (from search)
3. `CategoryEntry` → `ArticleDetailView` (from category, with context)

**Other tabs** use their own `NavigationStack` without shared path.

### Swipe Gesture System

MainTabView implements a unified `DragGesture` system with context-aware behavior:

| Navigation Depth | Left Swipe | Right Swipe | Threshold |
|-------------------|------------|-------------|-----------|
| Tab level (depth 0) | Next tab | Previous tab | 20% screen width / velocity 200 |
| Category list (depth 1) | Next category | Previous category | 10% / velocity 100 |
| Entry detail (depth 2) | Next entry | Previous entry | 10% / velocity 100 |

**Key design constraint:** Navigation is managed via `BrowseNavigationContext` (an `@Observable` class), NOT by replacing `NavigationPath`. Swipes at category/entry level modify the context's current index; the NavigationPath only changes for structural navigation. This avoids SwiftUI bounce-back issues.

### BrowseNavigationContext

Central state manager for Browse tab navigation:

```
depth 0 (grid) → depth 1 (category list) → depth 2 (entry detail)
```

Properties: `depth`, `currentCategory`, `currentEntryIndex`, `visibleEntries`, `hasContext`, `selectedSpeciesFilter`

Methods: `enterCategoryList()`, `enterEntryDetail()`, `enterEntryDetailWithoutContext()`, `returnToCategoryList()`, `returnToGrid()`, `navigateToEntryAtIndex()`

Injected via `.environment()` from PetToxicApp → consumed by BrowseView, CategoryListView, ArticleDetailView, MainTabView.

---

## ViewModels

### ArticleViewModel
Thin wrapper around BookmarkService. Methods: `isBookmarked()`, `toggleBookmark()`, `recordView()`.

### BrowseViewModel
Loads all items grouped by category from DatabaseService at init. Methods: `items(for:)`, `itemCount(for:)`.

### SearchViewModel
Debounced search (300ms) via Combine pipeline. Manages `searchText`, `selectedSpecies`, `searchResults`, `recentSearches` (UserDefaults, max 10).

**SearchContext singleton:** Passes pending search terms between views for cross-tab communication.

### SavedViewModel
Subscribes to BookmarkService publishers via Combine. Mirrors bookmarks, history, and recent searches for SavedView display.

---

## Features

### Toxin Database
~170 entries across 10 categories. Each entry has 5 species risks, sources, prevention tips, symptoms, onset timing, and cross-references. Entries can be cross-listed in multiple categories.

### Search
Home tab and Browse tab each have search bars. Debounced 300ms. Matches on name + alternate names. Results ranked by relevance score with match type classification.

### Browse with Species Filtering
Category grid → entry list with species filter chips:
- **Auto**: Filters to user's pet species (from My Pets profiles)
- **All**: Shows everything
- **Specific species**: Dog, Cat, Bird, Small Mammal, Reptile
- Sort: By severity (default) or alphabetical
- View: Grid (1-3 columns) or list

### My Pets (Pro)
Up to 5 pet profiles with: photo, name, species, breed (with autocomplete), sex, weight (lbs/kg), birthday/age, microchip number, vet info, poison control case numbers. SwiftData persistence. Auto-save on changes.

Pet profiles power:
- Auto species filter in Browse tab
- Emergency pet info card
- Pet Hero badge on Home tab

### Medical Glossary (Pro)
~213 medical terms with pronunciations, definitions, categories, and cross-references. A-Z browsing with search. Terms are highlighted in teal within article text (first occurrence, whole-word match).

### Lab Work Guide (Pro)
~63 lab parameters across 5 panels (CBC, Chemistry, Coagulation, Pancreas, Urinalysis). Each parameter explains what it measures, what high/low values mean, and species-specific notes. Browse by category or A-Z. Educational disclaimer prominent.

### Bookmarks & History
Bookmark any entry; view history tracks last 50 viewed items. Recent searches saved (max 10). All persisted to UserDefaults.

### Emergency Screen
Large poison control call buttons (ASPCA: 888-426-4435, Pet Poison Helpline: 855-764-7661). "What to have ready" checklist. Pet info card with vet contact and case numbers (Pro).

### Share
Share sheet generates formatted text + 1024x1024 card image via ImageRenderer. Includes app link.

### Quick Emergency Mode
Swiping right on the Home tab triggers Emergency view overlay without changing tabs.

---

## IAP Tiers

| Tier | Product ID | Unlocks |
|------|-----------|---------|
| **Pro** | `com.pettoxic.pro1` | My Pets, Medical Glossary, Lab Work Guide |
| **Pet Hero** | `com.pettoxic.supporter1` | Everything in Pro + Pet Hero badge + thank-you message |

**Gating pattern:** Views check `ProSettings.shared.isPro` / `.isSupporter`. Free users see locked cards with "PRO" badges that trigger upsell alerts on tap. Pro features use conditional rendering — locked = reduced opacity + lock icon + upsell; unlocked = full interaction.

**Purchase flow:** StoreKitService handles StoreKit 2 purchase → updates ProSettings flags → UI reacts via `@ObservedObject ProSettings.shared`.

---

## State Management Summary

| Pattern | Usage |
|---------|-------|
| `@Observable` | BrowseNavigationContext, PetStore |
| `ObservableObject` + `@Published` | All ViewModels, BookmarkService, ProSettings, StoreKitService, AppearanceSettings, GlossaryService |
| `@Environment` | BrowseNavigationContext (navigation state) |
| `@StateObject` | ViewModel instances in views |
| `@ObservedObject` | ProSettings.shared, StoreKitService.shared |
| `@AppStorage` | Grid columns, sort preference, view mode, disclaimer version, debug flags |
| `@Query` (SwiftData) | Pet list queries |
| UserDefaults | Bookmarks, history, recent searches, appearance |
| SwiftData | Pet profiles, PoisonControlCase records |

---

## App Entry Point

```swift
@main
struct PetToxicApp: App {
    @State private var browseNavigationContext = BrowseNavigationContext()

    init() {
        _ = StoreKitService.shared  // Initialize StoreKit
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(browseNavigationContext)
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: [Pet.self, PoisonControlCase.self])
    }
}
```

Key initialization chain:
1. StoreKitService loads products + checks entitlements
2. BrowseNavigationContext created as @State
3. SwiftData container registered for Pet + PoisonControlCase
4. Dark mode forced at scene level

---

## Key Patterns for Replication

1. **All data bundled** — no network calls, no server. Entries are hardcoded Swift arrays in service singletons.
2. **Singleton services** — DatabaseService, BookmarkService, GlossaryService, LabWorkGuideService, ProSettings, StoreKitService all use `.shared` pattern.
3. **Navigation context object** — Separate `@Observable` class tracks Browse navigation state; injected via `.environment()`. Avoids NavigationPath mutations for lateral navigation.
4. **IAP gating** — Single `ProSettings.shared.isPro` check gates all Pro features. Views render locked/unlocked states conditionally.
5. **Markdown text rendering** — Custom `GlossaryStyledText` splits on `\n\n` for paragraph spacing, highlights glossary terms in teal, highlights search terms in yellow. Uses `AttributedString(markdown:)` internally.
6. **Species mapping** — `PetSpecies` (35+ granular) maps to `Species` (5 broad) via `BrowseFilterService.petSpeciesToToxicSpecies()`. Auto filter uses this to personalize Browse.
7. **Swipe gestures** — Single DragGesture on MainTabView with context-aware thresholds. No gesture conflicts because entry/category swipes check `onEnded` translation (not intermediate `onChanged` state), avoiding ScrollView interference.

---

*Generated from live codebase — 79 Swift files, ~170 toxin entries, ~213 glossary terms, ~63 lab parameters*
