# Pet Toxic - iOS App

## Overview
Native iOS reference app for pet owners to quickly look up toxicity information. Works offline. Never provides medical advice.

## Technical Stack
- **Language:** Swift 5.9+
- **UI:** SwiftUI
- **iOS Target:** 17.6+
- **Architecture:** MVVM
- **Database:** SQLite with FTS5 for search
- **Dependencies:** Minimize; prefer native frameworks

---

## Build & Diagnostics

- **SourceKit false positives:** After file edits, SourceKit diagnostics may report errors like "Cannot find type in scope" or "Ambiguous use of init." These are false positives caused by SourceKit analyzing files in isolation without full project context. **Ignore these.** Always verify with an actual `xcodebuild` build.
- **Build command:** `xcodebuild -scheme PetToxic -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build`
- **Available simulators (iOS 26.1):** iPhone 17, iPhone 17 Pro, iPhone 17 Pro Max, iPhone Air, iPhone 16e, iPad Air/Pro/mini variants
- **macOS awk:** macOS ships with BSD `awk`, which does NOT support `match()` with capture groups (3rd argument). Use `gsub()` to extract values instead, or use `gawk` if installed. Never use `match($0, /pattern/, arr)` in scripts — it will fail silently or error on macOS.
- **Self-healing documentation:** When you encounter a platform-specific error, tool incompatibility, or unexpected gotcha during a session, **add a note to this CLAUDE.md file** under the appropriate section so future sessions don't repeat the same mistake. Treat this file as a living knowledge base.
- **Source root path:** The project working directory is `/Users/cristianofontes/Desktop/PetToxic/`, but Swift source files live under the `PetToxic/` subdirectory. When running scripts from the project root, always prefix source paths with `PetToxic/` (e.g., `PetToxic/Services/GlossaryService.swift`, not `Services/GlossaryService.swift`). Session instructions may omit this prefix — verify paths before running.
- **Script output validation:** After running extraction or audit scripts, always compare the actual output count against the expected count (e.g., `grep -c` the source, then count entries in the output file). Silent partial failures — where a script produces results but misses entries — are common with multi-line awk/sed patterns. Flag any mismatch immediately.
- **Working directory assumptions:** Session instruction documents may assume a different working directory than the actual one. Always confirm the real working directory with `pwd` or check the environment context before running any script verbatim from session instructions.
- **Edit tool requires Read first:** The Edit tool will fail with "File must be read first" if a file hasn't been read in the current session. When doing batch edits across many files, **read all target files before starting any edits**. If editing N files in parallel, issue N Read calls first, then N Edit calls. Sibling Edit calls also fail if one in the batch errors, so read everything upfront to avoid cascading failures.
- **SwiftData relationship inserts:** When adding a child record to a parent's relationship array (e.g., `pet.vaccinationRecords.append(newRecord)`), do NOT also call `modelContext.insert(newRecord)`. SwiftData handles the insert through the relationship — calling both causes a double-insert bug with duplicate records.
- **Glossary extraction — multi-line fields:** Fields in `GlossaryService.swift` (`definition`, `searchKeywords`, `relatedTerms`) can span multiple lines. Single-line awk/sed patterns will silently miss entries with wrapped fields. **Always** use a block-based approach: accumulate lines between `GlossaryTerm(` and the closing `),`, then parse the full block. Prefer `perl -ne` with a line-by-line accumulator over awk for glossary extraction. Never assume all fields fit on one line.

### SwiftUI Navigation & Gesture Gotchas

- **Never replace NavigationPath for lateral navigation.** Assigning a new `NavigationPath` to swap one entry for another (same depth) is unreliable — SwiftUI may process it as pop-then-push, causing bounce-backs, transient intermediate states, or routing swipes to the wrong navigation level. Instead, keep the path stable and switch displayed content in-place via an `@Observable` context (see `BrowseNavigationContext`). The `NavigationPath` should only change for structural navigation (push/pop levels).
- **`.navigationDestination` must be on the NavigationStack root.** Registering destinations on child views (e.g., inside `CategoryListView`) means they're only available when that child is rendered. Programmatic path changes resolve destinations from the root. All `.navigationDestination` modifiers live on `BrowseView`.
- **ScrollView competes with `.simultaneousGesture(DragGesture)`.** Even with `.simultaneousGesture`, a vertical `ScrollView` can prevent `onChanged` from reliably setting state (the horizontality guard fails due to gesture interference). For swipes over ScrollView content, check the **final** `value.translation` in `onEnded` rather than relying on intermediate `onChanged` state. See the `isDragging` bypass for contextual swipes in `MainTabView`.
- **Contextual swipes need different thresholds.** Swipes with visual drag feedback (tab switching) use 20% screen-width / velocity 200. Swipes without visual feedback (entry/category flicks) need lighter thresholds (10% / velocity 100) to feel responsive. Both use the same `DragGesture`; thresholds are selected based on `browseNavigationPath.count`.

### SF Symbol Compatibility

- **App targets iOS 17.6+.** Before using any SF Symbol, verify it exists in iOS 17. Newer symbols will cause runtime crashes on older devices.
- **Known iOS 17+ only symbols:** `liver.fill`, `stomach.fill`, `testtube.2`
- **Safe alternatives:** `cross.vial.fill`, `staroflife.fill`, `drop.triangle.fill`, `plus.forwardslash.minus`
- **Verification:** Check existing codebase usage with `grep "systemName"` to find patterns that are known to work.

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
| `PetToxic_Database_Audit_Rules.md` | Full audit rules: sources, content policies, species, severity, categories, fields, cross-references |
| `PetToxic_Database_Audit_Rules_ClaudeCode.md` | Condensed checklist for batch editing sessions |
| `EntryReferenceDocument.md` | Complete list of all 195 entries with UUIDs, severity, and categories |
| `Documentation/DataModels.md` | Data model specifications |
| `Documentation/Design/UI-Spec.md` | UI specifications |
| `Documentation/Design/StyleGuide.md` | Visual design guidelines |
| `PetToxic_DiseasesConditions_EntryTemplate.md` | Content & format template for Diseases & Conditions entries: 3 entry types (Infectious / Husbandry / Medical-Metabolic), field protocols, tone guidance, prohibited content, approved language |
| `ClaudeWeb_DiseaseEntryFormat.md` | Quick-reference for Claude Web: correct ToxicItem field order, category enum, Contents.json format, commit style |

**For entry editing sessions:** Read `PetToxic_Database_Audit_Rules_ClaudeCode.md` for quick rules or `PetToxic_Database_Audit_Rules.md` for full details. Use `EntryReferenceDocument.md` to look up UUIDs and verify cross-references.

**For disease/condition editing sessions:** Read `PetToxic_DiseasesConditions_EntryTemplate.md` for the full field-by-field protocol, 3 entry types (Type 1: Infectious, Type 2: Husbandry, Type 3: Medical/Metabolic), tone guidance, approved severity/zoonotic language, and the entry checklist. Use `ClaudeWeb_DiseaseEntryFormat.md` when generating instruction files via Claude Web. These entries follow a different content structure than toxin entries.

---

## Branch Strategy
- `main` — All work happens here
- `feature/[name]` — Short-lived branches for risky changes (big UI refactors, new features that could break things)

**Default behavior:** Work directly on `main`. Only create a feature branch when a change could break existing functionality or when explicitly requested by the user.

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

**For entry edits:** See audit checklist in `PetToxic_Database_Audit_Rules.md`.

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
│   │   ├── SeverityBadge.swift        # Toxicity level indicator
│   │   ├── TrialBannerView.swift      # 30-day trial banner (4 states)
│   │   └── VaccinationSummaryCard.swift # Vaccine status card (home screen)
│   ├── Models/
│   │   ├── Enums.swift                # Species, Severity, Category (incl. isProLocked), SeverityGroupLevel, MatchType
│   │   ├── NavigationContext.swift     # CategoryEntry, SeverityEntry, BrowseNavigationContext
│   │   ├── SearchResult.swift
│   │   ├── SpeciesRisk.swift
│   │   ├── ToxicItem.swift            # Main toxin data model
│   │   └── VaccinationRecord.swift    # SwiftData model for vaccine records
│   ├── Resources/
│   │   ├── Assets.xcassets/           # App icons, colors, images
│   │   ├── Info.plist
│   │   └── LaunchScreen.storyboard
│   ├── Services/
│   │   ├── AppearanceSettings.swift   # Dark/light mode (default: dark)
│   │   ├── BookmarkService.swift      # Save favorites
│   │   ├── DatabaseService.swift      # Toxin data (hardcoded, SQLite planned)
│   │   ├── DiseasesConditionsService.swift # Pro-locked disease/condition entries
│   │   ├── SearchService.swift        # FTS5 search
│   │   ├── TrialManager.swift         # 30-day Pro trial (Keychain-backed)
│   │   └── VaccinePresets.swift       # Species-keyed vaccine presets & status enum
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
│       │   ├── CategoryGridItem.swift
│       │   └── DiseasesConditionsListView.swift # Pro-locked species-grouped disease list
│       ├── Emergency/
│       │   └── EmergencyView.swift    # Poison control contacts
│       ├── Saved/
│       │   ├── BookmarksListView.swift
│       │   ├── HistoryListView.swift
│       │   └── SavedView.swift
│       ├── MyPets/
│       │   ├── PetFormView.swift      # Pet profile form
│       │   ├── PetListView.swift
│       │   ├── PetPhotoPickerView.swift
│       │   └── VaccinationLogView.swift # Vaccine log + add/edit sheet
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
| Add/edit disease/condition entry | `Services/DiseasesConditionsService.swift` (Pro-locked) |
| Modify toxin data model | `Models/ToxicItem.swift`, `Models/SpeciesRisk.swift` |
| Change severity levels/colors | `Models/Enums.swift` (Severity enum) |
| Browse by severity groups | `Models/Enums.swift` (SeverityGroupLevel), `Views/Browse/BrowseView.swift` (SeverityListView) |
| Add new category | `Models/Enums.swift` (Category enum) |
| Modify article display | `Views/Article/ArticleDetailView.swift` |
| Change share text format | `Views/Article/ArticleDetailView.swift` (generateShareText) |
| Update disclaimer text | `Components/DisclaimerView.swift` |
| Modify search behavior | `Services/SearchService.swift` |
| Change default appearance | `Services/AppearanceSettings.swift` |
| Add new tab | `Views/MainTabView.swift` |
| Emergency contacts | `Components/PoisonControlButton.swift` |
| Trial/Pro gating logic | `Services/TrialManager.swift`, `Services/ProSettings.swift` |
| Trial banner on home | `Components/TrialBannerView.swift` |
| Vaccination records/log | `Views/MyPets/VaccinationLogView.swift` |
| Vaccine presets/intervals | `Services/VaccinePresets.swift` |
| Vaccination data model | `Models/VaccinationRecord.swift` |
| Vaccination summary (home) | `Components/VaccinationSummaryCard.swift` |
| Browse navigation context | `Models/NavigationContext.swift` |
| Diseases & Conditions list | `Views/Browse/DiseasesConditionsListView.swift` |
| Severity explainer entry | `Services/DatabaseService.swift` (UUID: `B3F1A2D4-E5C6-47F8-9A0B-1C2D3E4F5A6B`) |

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

*Last Updated: March 2026 (Session 144)*
