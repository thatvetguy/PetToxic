# Disease Entry Instruction Format — Reference for Claude Web

Use this document when generating session instruction files for Diseases & Conditions entry rewrites in the PetToxic app.

---

## Target File

The file is always:
```
PetToxic/Services/DiseasesConditionsService.swift
```
NOT `DatabaseService.swift`.

---

## Branch

All work happens on `main`. Do NOT create feature branches for content rewrites.

---

## Thumbnail Asset

Contents.json uses **1x only** (no 2x/3x slots):

```json
{
  "images": [
    {
      "filename": "ENTRY_thumb.png",
      "idiom": "universal",
      "scale": "1x"
    }
  ],
  "info": {
    "author": "xcode",
    "version": 1
  }
}
```

---

## ToxicItem Field Order

Fields MUST appear in this exact order (matches the Swift initializer):

```swift
ToxicItem(
    id:                        // UUID
    name:                      // String
    alternateNames:            // [String]
    categories:                // [Category]
    imageAsset:                // String?
    description:               // String (""" multi-line)
    toxicityInfo:              // String (""" multi-line with bold headers)
    toxicityInfoSectionTitle:  // String? — always "What makes it harmful?"
    onsetTime:                 // OnsetTime(early:, delayed:)
    symptoms:                  // [String]
    entrySeverity:             // Severity? — always nil for disease entries
    speciesRisks:              // [SpeciesRisk]
    preventionTips:            // [String]?
    sources:                   // [String]
    relatedEntries:            // [String]? — UUID strings or nil
)
```

---

## Category Enum Value

The correct enum case is:
```swift
categories: [.diseasesAndConditions]
```

NOT `.diseasesConditions`, NOT `.informational`.

---

## Entry Severity

Always `nil` for all Diseases & Conditions entries:
```swift
entrySeverity: nil
```

Species-level severity is set on each `SpeciesRisk` — that's where the meaningful severity data lives.

---

## Sort Order Registration (Non-Infectious Entries Only)

Entries are sorted in the app: **infectious diseases first** (alphabetically), then **non-infectious conditions** (alphabetically) within each species group.

For **Type 2 (Husbandry)** or **Type 3 (Medical/Metabolic)** entries, the instruction file MUST include a step to add the entry's UUID to `nonInfectiousEntryIDs` in `DiseasesConditionsService.swift`:

```swift
private static let nonInfectiousEntryIDs: Set<String> = [
    "1D000001-0000-0000-0000-000000000005",  // Metabolic Bone Disease (MBD)
    "NEW-UUID-HERE",                          // New non-infectious entry
]
```

Type 1 (Infectious) entries do NOT need this step — they sort as infectious by default.

---

## Multi-line String Format

Use `"""` triple-quoted strings with leading whitespace matching the surrounding indentation. Use `\` line-continuation backslashes to prevent unwanted line breaks in rendered text. Bold section headers use `**Header Text**`:

```swift
description: """
                First paragraph of text continues with backslash \
                continuations to keep lines under ~80 chars in source.

                Second paragraph separated by a blank line.
                """,
```

---

## Commit Message Format

```
content: Session NNN — EntryName full entry rewrite

- Full content rewrite from stub
- Thumbnail: entry_thumb added to asset catalog
- entrySeverity: nil (consistent with all Diseases & Conditions entries)
- speciesRisks: [list species and severity levels]
- [any omitted species and why]
- Sources: [abbreviated source list]
```
