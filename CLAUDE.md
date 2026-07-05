# Pet Toxic - iOS App

## Overview
Native iOS reference app for pet owners to quickly look up toxicity information. Works offline. Never provides medical advice.

## Reference Hubs
- `~/Desktop/SASI_Projects/CLAUDE.md` — portfolio context, accounts, git conventions, **Core Principles for Veterinary Reference Apps** (shared across all PetToxic apps).
- `~/Desktop/SASI_Projects/Gotchas_CrossApp.md` — cross-app store submission, tooling, content-safety landmines. Each entry has a stable ID (e.g. `GC-APPL-002`, `GC-SAFE-001`); cite by ID rather than restating. See the top of that file for the promotion rule (when a gotcha belongs here vs. in the hub).

## Multi-AI Review Workflow

This app follows the SASI **Claude implements / Codex reviews** workflow — full definition in `~/Desktop/SASI_Projects/MultiAI_Workflow_Convention.md` (roles, P1/P2/P3 findings, cadence, OUT-OF-PROCESS marker). PetToxic specifics:

- **Vault handoff:** `~/Documents/Dev_Projects/PetToxic/PetToxic_Handoff.md` — read at session start, update at session end for non-trivial work. Outside the git repo; git wins on conflicts.
- **Codex reads `AGENTS.md`** (repo root) and reviews from its clone at `~/Desktop/Codex/PetToxic`.
- **Commit + push at review checkpoints** (spec, implementation slice, refinement) so Codex can pull — this overrides the default "only commit when asked" habit for checkpoints. Keep commits scoped; ask before bundling unrelated work.
- **Cadence dial:** full cadence (spec → Codex spec-review → implement → Codex diff-review) for content/clinical changes, paywall/billing, and store config; light cadence (implement → post-hoc review) for small low-risk changes; skip for trivial mechanical edits.

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
- **Content JSON validator:** `python3 Scripts/validate_content.py` checks `Content/toxins.json` + `diseases.json` against the Session-164 schema and the content rules below (UUID format, enums, cross-reference resolution, markdown-list rendering rule, editorial policy warnings). Run `--self-test` after modifying the script. Pre-existing errors are baselined in `Scripts/known_content_errors.txt` (only NEW errors fail; remove lines as fixes land, delete when empty — planned during the JSON source-of-truth migration). Enforced three ways: a PostToolUse hook in `.claude/settings.json` (fires when Claude edits the JSON), a git pre-commit hook (source copy in `Scripts/hooks/pre-commit`, reinstall with `cp Scripts/hooks/pre-commit .git/hooks/ && chmod +x .git/hooks/pre-commit`), and GitHub Actions on every push/PR (`.github/workflows/validate-content.yml`).
- **Glossary extraction — multi-line fields:** Fields in `GlossaryService.swift` (`definition`, `searchKeywords`, `relatedTerms`) can span multiple lines. Single-line awk/sed patterns will silently miss entries with wrapped fields. **Always** use a block-based approach: accumulate lines between `GlossaryTerm(` and the closing `),`, then parse the full block. Prefer `perl -ne` with a line-by-line accumulator over awk for glossary extraction. Never assume all fields fit on one line.

### Content Formatting Gotchas

- **Scientific names must be italicized in entry text.** Use markdown italic syntax (`*Genus species*`) in `description` and `toxicityInfo` fields. Every plant/food entry should have at least the genus name italicized in the description. Use abbreviated form after first mention (e.g., `*Aconitum napellus*` first, then `*A. napellus*`). This convention was established during the March 2026 plant/food audit — all existing entries have been updated.
- **Glossary highlighting is first-mention-only.** `GlossaryStyledText` tracks which terms have been highlighted across all paragraphs in an entry and only highlights the first occurrence of each glossary term. This prevents cluttered teal highlighting in long entries. The glossary `searchKeywords` were also pruned in March 2026 — common words like "vomiting", "liver", "kidney", "drooling", "symptoms" were removed to reduce over-highlighting.
- **No markdown list syntax in `description` or `toxicityInfo` fields.** Lines starting with `- ` (markdown lists) use single `\n` between items. `GlossaryStyledText` splits on `\n\n` for paragraph breaks, and `AttributedString(markdown:)` swallows single `\n`, causing list items to run together with no visible separation. **Instead:** use `\n\n`-separated paragraphs with bold headers (`**EARS:**`, `**NOSE:**`, etc.) or convert short lists to inline prose. This applies to `DatabaseService.swift` and `DiseasesConditionsService.swift`. The `symptoms` and `preventionTips` arrays are unaffected — they render as individual list rows.

### SwiftUI Navigation & Gesture Gotchas

- **Never replace NavigationPath for lateral navigation.** Assigning a new `NavigationPath` to swap one entry for another (same depth) is unreliable — SwiftUI may process it as pop-then-push, causing bounce-backs, transient intermediate states, or routing swipes to the wrong navigation level. Instead, keep the path stable and switch displayed content in-place via an `@Observable` context (see `BrowseNavigationContext`). The `NavigationPath` should only change for structural navigation (push/pop levels).
- **`.navigationDestination` must be on the NavigationStack root.** Registering destinations on child views (e.g., inside `CategoryListView`) means they're only available when that child is rendered. Programmatic path changes resolve destinations from the root. All `.navigationDestination` modifiers live on `BrowseView`.
- **ScrollView competes with `.simultaneousGesture(DragGesture)`.** Even with `.simultaneousGesture`, a vertical `ScrollView` can prevent `onChanged` from reliably setting state (the horizontality guard fails due to gesture interference). For swipes over ScrollView content, check the **final** `value.translation` in `onEnded` rather than relying on intermediate `onChanged` state. See the `isDragging` bypass for contextual swipes in `MainTabView`.
- **Contextual swipes need different thresholds.** Swipes with visual drag feedback (tab switching) use 20% screen-width / velocity 200. Swipes without visual feedback (entry/category flicks) need lighter thresholds (10% / velocity 100) to feel responsive. Both use the same `DragGesture`; thresholds are selected based on `browseNavigationPath.count`.

### UUID Generation for Entries

- **UUIDs must contain only valid hexadecimal characters (0-9, a-f).** When generating UUIDs for new `ToxicItem` or disease entries, never embed entry names or descriptive text into UUID segments. Letters g-z are not valid hex and will cause `UUID(uuidString:)` to return `nil`, crashing the app on the force-unwrap `!`. Use random hex or structured hex patterns (e.g., `a1b2c3d4-0000-0000-0000-000c1ad00501`), not mnemonics like `gymnocladus01` or `eranthis00001`.
- **Always validate generated UUIDs** by confirming every character in each segment is 0-9 or a-f before committing.

### SF Symbol Compatibility

- **App targets iOS 17.6+.** Before using any SF Symbol, verify it exists in iOS 17. Newer symbols will cause runtime crashes on older devices.
- **Known iOS 17+ only symbols:** `liver.fill`, `stomach.fill`, `testtube.2`
- **Safe alternatives:** `cross.vial.fill`, `staroflife.fill`, `drop.triangle.fill`, `plus.forwardslash.minus`
- **Verification:** Check existing codebase usage with `grep "systemName"` to find patterns that are known to work.

---

## Core Principles
See **Core Principles for Veterinary Reference Apps** in `~/Desktop/SASI_Projects/CLAUDE.md` (offline-first, no medical advice, always-visible disclaimer, speed, accessibility, authoritative content).

**PetToxic-specific additions:**
- Information accessible within 2-3 taps — users may be panicked.
- 44pt minimum touch targets (iOS HIG).
- No user accounts, no cloud sync, no analytics tracking, no ads.

---

## Reference Documents

| Document | Purpose |
|----------|---------|
| `PetToxic_Database_Audit_Rules.md` | Full audit rules: sources, content policies, species, severity, categories, fields, cross-references |
| `PetToxic_Database_Audit_Rules_ClaudeCode.md` | Condensed checklist for batch editing sessions |
| `EntryReferenceDocument.md` | Complete list of all entries with UUIDs, severity, and categories |
| `Documentation/DataModels.md` | Data model specifications |
| `Documentation/Design/UI-Spec.md` | UI specifications |
| `Documentation/Design/StyleGuide.md` | Visual design guidelines |
| `PetToxic_DiseasesConditions_EntryTemplate.md` | Content & format template for Diseases & Conditions entries: 3 entry types (Infectious / Husbandry / Medical-Metabolic), field protocols, tone guidance, prohibited content, approved language |
| `ClaudeWeb_DiseaseEntryFormat.md` | Quick-reference for Claude Web: correct ToxicItem field order, category enum, Contents.json format, commit style |
| `Documentation/EmergencyVet_And_Tracking_Reference.md` | Porting guide for Emergency Vet + Call Tracking features (Equine Edition) |
| `ClaudeCode_Session164_AndroidJSONSchema.md` | Finalized JSON schema for shared content files (toxins.json / diseases.json), enum values, migration plan |

**For entry editing sessions:** Read `PetToxic_Database_Audit_Rules_ClaudeCode.md` for quick rules or `PetToxic_Database_Audit_Rules.md` for full details. Use `EntryReferenceDocument.md` to look up UUIDs and verify cross-references.

**For disease/condition editing sessions:** Read `PetToxic_DiseasesConditions_EntryTemplate.md` for the full field-by-field protocol, 3 entry types (Type 1: Infectious, Type 2: Husbandry, Type 3: Medical/Metabolic), tone guidance, approved severity/zoonotic language, and the entry checklist. Use `ClaudeWeb_DiseaseEntryFormat.md` when generating instruction files via Claude Web. These entries follow a different content structure than toxin entries.

---

## Project Structure
Open the project in Xcode (or `ls PetToxic/` from the repo root). Swift sources live under `PetToxic/` with conventional MVVM folders: `App/`, `Components/`, `Models/`, `Services/`, `ViewModels/`, `Views/`, `Utilities/`, `Resources/`. Cross-platform JSON lives under `Content/`. Extraction script under `Scripts/`. Design/data docs under `Documentation/`. For "where do I edit X?" see the Common File Locations table below.

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
| Emergency vet (global, free) | `Services/EmergencyVetSettings.swift`, `Components/EmergencyVetButton.swift`, `Views/Settings/EmergencyVetFormView.swift` |
| Plant ID banner (FB group) | `Components/PlantIDBannerCard.swift` |
| Anonymous event tracking | `Services/CallTrackingService.swift`, `CloudflareWorker/worker.js` |
| Phone number formatting | `Utilities/Constants.swift` (`PhoneFormatter`) |
| Trial/Pro gating logic | `Services/TrialManager.swift`, `Services/ProSettings.swift` |
| Trial banner on home | `Components/TrialBannerView.swift` |
| Vaccination records/log | `Views/MyPets/VaccinationLogView.swift` |
| Vaccine presets/intervals | `Services/VaccinePresets.swift` |
| Vaccination data model | `Models/VaccinationRecord.swift` |
| Vaccination summary (home) | `Components/VaccinationSummaryCard.swift` |
| Browse navigation context | `Models/NavigationContext.swift` |
| Diseases & Conditions list | `Views/Browse/DiseasesConditionsListView.swift` (browsable by free users, entries Pro-locked) |
| Upgrade/purchase flow | `Views/Settings/UpgradeView.swift` |
| Severity explainer entry | `Services/DatabaseService.swift` (UUID: `B3F1A2D4-E5C6-47F8-9A0B-1C2D3E4F5A6B`) |
| JSON content (shared) | `Content/toxins.json`, `Content/diseases.json` |
| Re-extract JSON from Swift | `Scripts/extract_content.swift` — compile & run (see header comment for usage) |
| Validate content JSON | `Scripts/validate_content.py` — run after any content change or re-extraction |

---

## Android App

The Android version lives in a **separate repo** at `~/Desktop/PetToxicAndroid/` (Kotlin + Jetpack Compose, package `com.pettoxic.android`).

Content is shared via the JSON files in `Content/`. After editing entries in `DatabaseService.swift` or `DiseasesConditionsService.swift`, re-run the extraction script to regenerate the JSON files, then copy them to the Android project's `app/src/main/assets/`.

**Extraction workflow:**
```bash
# From this repo's root:
swiftc -framework SwiftUI \
  PetToxic/Models/Enums.swift \
  PetToxic/Models/ToxicItem.swift \
  PetToxic/Models/SpeciesRisk.swift \
  PetToxic/Services/DatabaseService.swift \
  PetToxic/Services/DiseasesConditionsService.swift \
  Scripts/extract_content.swift \
  -o Scripts/extract_content
./Scripts/extract_content

# Then copy to Android:
cp Content/toxins.json Content/diseases.json ~/Desktop/PetToxicAndroid/app/src/main/assets/
```

---

*Last Updated: March 2026*
