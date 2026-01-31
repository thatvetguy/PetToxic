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

---

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

---

## Key Constraints

**Do NOT include:**
- Dosage or "safe amount" calculations
- Treatment instructions of any kind
- User accounts or cloud sync
- Advertisements or analytics tracking
- In-app purchases (v1.0)

---

## Reference Documents

| Document | Purpose |
|----------|---------|
| `PetToxic_Database_Audit_Rules.md` | Full audit rules reference |
| `PetToxic_Database_Audit_Rules_ClaudeCode.md` | Condensed rules for batch files |
| `EntryReferenceDocument.md` | Complete list of all entries with UUIDs |
| `Documentation/DataModels.md` | Data model specifications |
| `Documentation/Design/UI-Spec.md` | UI specifications |
| `Documentation/Design/StyleGuide.md` | Visual design guidelines |

---

## Categories

| Category | Key | Icon | Notes |
|----------|-----|------|-------|
| Foods | `.foods` | `fork.knife` | |
| Plants | `.plants` | `leaf.fill` | |
| Medications | `.medications` | `pills.fill` | Includes pet meds & pesticides |
| Cleaning Products | `.cleaningProducts` | `bubbles.and.sparkles` | |
| Garage & Garden | `.garageGarden` | `wrench.and.screwdriver.fill` | |
| Household Items | `.householdItems` | `house.fill` | |
| Recreational Substances | `.recreationalSubstances` | `smoke.fill` | |
| Outdoor Hazards | `.outdoorHazards` | `figure.hiking` | Animal encounters, environmental |
| Informational | `.informational` | `info.circle.fill` | Umbrella entries, mechanical hazards |

**Cross-listing:** Entries can appear in multiple categories (e.g., Hops in Foods + Plants).

---

## Severity Levels

| Level | Definition | UI Color | Recommendation |
|-------|------------|----------|----------------|
| `.severe` | Life-threatening | Red | Immediate emergency care |
| `.high` | Serious symptoms expected | Orange | Prompt veterinary care |
| `.moderate` | Significant symptoms possible | Yellow | Veterinary evaluation recommended |
| `.low` | Mild, self-limiting | Green | Monitor; contact vet if worsens |
| `nil` | Informational entry | Gray | Educational/umbrella content |

**Sorting:** Entries sort by severity (SEVERE → HIGH → MODERATE → LOW → nil).

---

## Species Requirements

**Every entry MUST include all 5 species:**

| Species | Includes |
|---------|----------|
| `.dog` | All domestic dogs |
| `.cat` | All domestic cats |
| `.smallMammal` | Rabbits, guinea pigs, hamsters, rats, mice, ferrets, chinchillas, gerbils |
| `.bird` | Budgies, canaries, parrots, macaws, cockatiels, finches, pet birds |
| `.reptile` | Snakes, lizards, turtles, tortoises, bearded dragons, geckos |

**Research notes:**
- Small mammals: Research rabbits, guinea pigs, AND rodents separately (sensitivities vary)
- Birds: Consider both small (budgies) and large (parrots) — small birds often more sensitive
- Reptiles: Research snakes, lizards, AND chelonians separately if needed

---

## Entry Editing Rules

### Sources

| Action | Rule |
|--------|------|
| **REMOVE** | "Veterinary Information Network (VIN)" or "VIN" monograph sources |
| **KEEP** | "Veterinary Partner" (VIN's public website — acceptable) |
| **REQUIRE** | Minimum 3 publicly accessible sources per entry |

**Preferred sources (in order):**
1. ASPCA Animal Poison Control Center
2. Pet Poison Helpline
3. Merck Veterinary Manual
4. Peer-reviewed journals (JAVMA, JVIM, JVECC)
5. Veterinary school websites (UC Davis, Cornell, Purdue)
6. Veterinary Partner
7. VCA Animal Hospitals, PetMD

### Content to REMOVE

| Remove | Reason |
|--------|--------|
| VIN sources | Subscription-only; not publicly accessible |
| Dosage thresholds (mg/kg) | Implies safe amounts exist |
| LD50 data | Laypersons don't understand; implies thresholds |
| "Safe amount" language | Never imply any quantity is safe |
| "Generally well tolerated" | Could discourage seeking care |
| Prognosis statements | "Prognosis is excellent/poor" — depends on many factors |
| Treatment protocols | Constitutes medical advice |
| Specific doctor/author names | Use organization names only |

### Content to KEEP or ADD

| Keep/Add | Notes |
|----------|-------|
| Practical examples | "Even a small amount can be dangerous to cats" |
| Plain language explanations | "methemoglobinemia (a condition where blood cannot carry oxygen properly)" |
| Observable symptoms | What owners might see (not diagnosis) |
| Species-specific warnings | Important safety information |
| Common exposure scenarios | Helps with prevention |
| Common misspellings | Improves searchability (e.g., "metaldahyde") |
| Seasonal context | When exposures peak (spring/fall for fertilizers) |
| Product identification tips | Colors, packaging details |
| "Pet-safe" product cautions | Marketing claims vs. reality |

### Permitted First Aid

| Permitted | Example |
|-----------|---------|
| Bathing/rinsing | "Bathe to remove substance from fur" |
| Eye rinsing | "Rinse eyes with clean water or saline" |
| Remove from exposure | "Move pet to fresh air" |
| Karo syrup | For expected hypoglycemia (xylitol, diabetes meds) |

### Language Guidelines

- **Target audience:** Pet owners without medical training
- **Jargon format:** "technical term (plain language explanation)"
- **Use:** "Animal poison control" (not specific hotline names — numbers listed separately)
- **Tone:** Informative but urgent; never dismissive of risk

---

## Cross-References (relatedEntries)

**All cross-references must be BIDIRECTIONAL.**

If Entry A links to Entry B, Entry B must link back to Entry A.

**Common cross-reference patterns:**
- Umbrella → Specific entries (Rodenticides → Bromethalin, Anticoagulants, etc.)
- Same toxic mechanism (Cocoa Mulch ↔ Chocolate — both methylxanthines)
- Combined products (Fertilizers ↔ Herbicides — "weed and feed")

---

## Informational Entries

Entries describing **mechanical hazards** (not chemical toxicosis) or **umbrella/educational content**:

| Setting | Value |
|---------|-------|
| `entrySeverity` | `nil` |
| `categories` | Include `.informational` (can be cross-listed with other categories) |

**Examples:**
- Mechanical hazards: Corn Cob, Fruit Pits, Expanding Glues (Gorilla Glue), Linear Foreign Bodies
- Umbrella entries: Rodenticides, Pesticides & Insecticides, Calcium Oxalate Plants

---

## Fields Reference

### Fields to EDIT during audits
- `speciesRisks` — Add missing species
- `sources` — Remove VIN, ensure 3+ remain
- `toxicityInfo` / `description` — Remove prohibited content, add plain language
- `relatedEntries` — Add cross-references (bidirectional)
- `alternateNames` — Add misspellings, brand names, synonyms
- `categories` — Add cross-listings if appropriate
- `entrySeverity` — Set to `nil` for informational entries

### Fields NOT to EDIT
- `id` (UUID) — Breaking change; affects app functionality
- `name` — Affects search and navigation
- `imageAsset` / `thumbnailURL` — Linked to external assets; coordinate with user

---

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

**Example commit message:**
```
feat: Session 75 Garage & Garden Audit - Mothballs, Expanding Glues

- Mothballs: Remove VIN, remove "safe amount" language
- Expanding Glues: Convert to Informational entry, add 3 species
```

---

## Plan Mode
- Keep plans concise. Sacrifice grammar for brevity.
- End each plan with unresolved questions, if any.

---

## Questions Before Coding

1. Does this feature work offline?
2. Could this be construed as medical advice?
3. Is the disclaimer visible?
4. Does it meet accessibility requirements?
5. Is the code testable?
6. Correct branch?

**Additional questions for entry edits:**
7. Are all 5 species present with severity + notes?
8. Is VIN removed from sources? Are 3+ sources remaining?
9. Is any "safe amount" language present that should be removed?
10. Are cross-references bidirectional?

---

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

---

## Common File Locations

| Task | File(s) |
|------|---------|
| Add/edit toxin entry | `Services/DatabaseService.swift` |
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

---

## Audit Progress Tracking

| Category | Entries | Status |
|----------|---------|--------|
| Plants | ~48 | ✅ Complete |
| Foods | ~17 | ✅ Complete |
| Medications | ~24 | ✅ Complete |
| Garage & Garden | ~21 | ✅ Complete |
| Household Items | ~15 | ✅ Complete |
| Cleaning Products | 9 | ✅ Complete |
| Recreational Substances | 6 | ✅ Complete |
| Outdoor Hazards | 12 | ✅ Complete |

*All 8 main categories audited. Remaining: Informational entries (~15), common toxicities enhancement, new Albuterol entry.*

---

## Session Handoff Protocol

When ending a session, create a handoff document including:
1. Work completed this session
2. Species/content additions made
3. Cross-references added
4. VIN sources removed
5. Current audit status
6. Next priority tasks
7. Any unresolved questions or issues

Handoff files: `Handoff_SessionXX_to_SessionYY.md`

---

*Last Updated: January 2026 (Session 85)*
