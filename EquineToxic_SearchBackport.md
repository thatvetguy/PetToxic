# Claude Code Instruction File
## EquineToxic — Two Backported Improvements from PetToxic

---

## Overview

PetToxic (the companion animal edition) has been updated with two improvements
that should be backported to EquineToxic for consistency:

1. **Search: Include pro-locked entries in search results for all users**
   (currently EquineToxic excludes them entirely)
2. **Section header: Change disease/condition entry header to "What makes it harmful?"**
   (currently reads "How does it affect horses?" or similar)

Both changes are independent and can be implemented in either order.

---

## Task 1: Search Backport

### Background

EquineToxic currently excludes pro-locked disease/condition entries from the
search corpus entirely. Non-Pro users who search for "rabies" or "strangles"
see no results — they don't know the content exists.

PetToxic's approach is better for both user experience and Pro conversion:
- All entries appear in search results for ALL users
- Disease/condition entries show a PRO badge in the results list
- Non-Pro users who tap a disease entry see an upsell alert instead of the article
- This surfaces pro content organically and creates natural upsell moments

### Step 1 — SearchService

Find the file that builds the search corpus (likely `Services/SearchService.swift`
or similar).

Currently, disease/condition entries from `DiseasesConditionsService` (or
equivalent) are excluded. Change this so all disease entries are included in
the search corpus for ALL users regardless of Pro status.

### Step 2 — Search Result Row

Find the view that renders individual search result rows (likely
`Views/Search/SearchResultRow.swift` or similar).

Add a PRO badge indicator on rows where the entry belongs to the
`.diseasesAndConditions` category (or equivalent pro-locked category in
EquineToxic). The badge should be visible to all users including non-Pro.

Example pattern:
```swift
if entry.categories.contains(.diseasesAndConditions) {
    Text("PRO")
        .font(.caption2.bold())
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .background(Color.yellow.opacity(0.2))
        .foregroundColor(.yellow)
        .clipShape(Capsule())
}
```

### Step 3 — Search Result Tap Gating

Find where search result taps are handled (likely `Views/Search/SearchView.swift`
or the result row's tap gesture).

Add gating logic:
```swift
if entry.categories.contains(.diseasesAndConditions) && !proSettings.isPro {
    // show upsell alert
} else {
    // navigate to ArticleDetailView normally
}
```

The upsell alert should match the pattern already used in the Browse tab
locked tile flow.

### Step 4 — Verify

- Build succeeds
- Non-Pro user: disease entries appear in search with PRO badge; tapping shows upsell
- Pro user: disease entries appear in search; tapping opens article normally
- Trial user: treated as Pro (full access during trial period)
- Existing toxin search results unaffected

---

## Task 2: Section Header Change

### Background

Disease and condition entries currently display a section header that reads
something like "How does it affect horses?" This should be changed to
**"What makes it harmful?"** for consistency with PetToxic and because the
phrasing works better across all entry types (infectious diseases, metabolic
conditions, husbandry issues).

### Step 1 — Locate the property

Find the `ToxicItem` model (or equivalent) and locate the `toxicityInfoSectionTitle`
property (or equivalent — may be named differently in EquineToxic).

### Step 2 — Update all disease/condition entries

In `DiseasesConditionsService.swift` (or equivalent service file holding
disease entries), change the `toxicityInfoSectionTitle` value on every entry
from the current string to:

```
"What makes it harmful?"
```

Apply to all disease/condition entries in the service.

### Step 3 — Verify fallback unchanged

Confirm that toxin entries in `DatabaseService.swift` (which do not set
`toxicityInfoSectionTitle`) still display **"Why is it toxic?"** as before.
The fallback behavior must be unchanged.

### Step 4 — Build and verify

- Build succeeds with no errors
- Disease entry article view shows "What makes it harmful?"
- Toxin entry article view still shows "Why is it toxic?"

---

## Notes

- These two tasks are independent — implement in either order
- Both are backports of patterns already working in PetToxic
- No model changes should be needed beyond the section header string update
- Do not change Pro gating logic, trial logic, or upsell flows — only the
  search corpus inclusion and section header text are changing
