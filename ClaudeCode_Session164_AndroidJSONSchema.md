# PetToxic — JSON Content Schema
## Finalized Session 164 — March 2026

---

## Overview

Two separate JSON files will serve as the single source of truth for all PetToxic content,
shared between iOS and Android apps.

| File | Contents | Current iOS source |
|------|----------|--------------------|
| `toxins.json` | Standard toxin + informational entries | `DatabaseService.swift` |
| `diseases.json` | Diseases & Conditions entries (Pro-locked) | `DiseasesConditionsService.swift` |

**Why two files, not one:** D&C entries have unique fields (`entryType`), always-constant
values that are omitted (`entrySeverity`, `categories`, `toxicityInfoSectionTitle`), and
separate Pro-locking logic. Keeping them apart gives each file a clean, tight schema.

**Why not one unified file with optional fields:** Schema validation becomes ambiguous —
"required for diseases, optional for toxins" is hard to enforce. Two files with strict
schemas are easier to validate and reason about.

Standard and informational toxin entries share the same struct (`ToxicItem`) and live in
the same file. The distinction is the `entrySeverity` value (`null` = informational),
not a structural difference.

---

## Schema Version

Both files include a root `version` field (integer). Bump when fields are added or removed.
This lets both platforms detect schema changes without guessing.

```json
{
  "version": 1,
  "entries": [...]
}
```

---

## toxins.json

### Example entry

```json
{
  "id": "B3F1A2D4-E5C6-47F8-9A0B-1C2D3E4F5A6B",
  "name": "Chocolate",
  "alternateNames": ["cocoa", "cacao", "dark chocolate"],
  "categories": ["foods", "holidayHazards"],
  "imageAsset": "chocolate",
  "description": "Chocolate is made from...",
  "toxicityInfo": "Chocolate contains theobromine...",
  "onsetTime": {
    "early": "Caffeine effects begin within...",
    "delayed": "Theobromine is metabolized slowly..."
  },
  "symptoms": ["Vomiting", "Restlessness"],
  "entrySeverity": "severe",
  "speciesRisks": [
    {
      "species": "dog",
      "severity": "high",
      "notes": "Dogs are commonly affected..."
    }
  ],
  "preventionTips": ["Store all chocolate products..."],
  "sources": ["ASPCA Animal Poison Control Center"],
  "relatedEntries": ["UUID-of-related-entry"]
}
```

### Field reference

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `id` | string (UUID) | Yes | Uppercase hex, 8-4-4-4-12 format |
| `name` | string | Yes | Display name |
| `alternateNames` | string[] | Yes | Can be `[]` |
| `categories` | string[] | Yes | 1+ values (see allowed values below). Never `diseasesAndConditions`. |
| `imageAsset` | string \| null | Yes | Asset catalog name or `null` |
| `description` | string | Yes | Plain text or markdown with bold headers |
| `toxicityInfo` | string | Yes | Plain text or markdown with bold headers |
| `onsetTime` | object \| null | Yes | See OnsetTime below, or `null` |
| `symptoms` | string[] | Yes | Can be `[]` |
| `entrySeverity` | string \| null | Yes | See allowed values below. `null` = informational. |
| `speciesRisks` | object[] | Yes | Can be `[]`. See SpeciesRisk below. |
| `preventionTips` | string[] \| null | Yes | `null` if none |
| `sources` | string[] | Yes | 1+ values |
| `relatedEntries` | string[] \| null | Yes | UUID strings or `null` |

---

## diseases.json

### Example entry

```json
{
  "id": "1D000001-0000-0000-0000-000000000001",
  "name": "Rabies",
  "entryType": "infectious",
  "alternateNames": ["rabies virus", "lyssavirus"],
  "imageAsset": "rabies_thumb",
  "description": "Rabies is a viral disease...",
  "toxicityInfo": "**How It Harms the Body**\n\n...",
  "onsetTime": {
    "early": "...",
    "delayed": "..."
  },
  "symptoms": ["Behavioral changes", "Paralysis"],
  "speciesRisks": [
    {
      "species": "dog",
      "severity": "severe",
      "notes": "..."
    }
  ],
  "preventionTips": ["Vaccinate all pets..."],
  "sources": ["Merck Veterinary Manual"],
  "relatedEntries": null
}
```

### Field reference

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `id` | string (UUID) | Yes | Uppercase hex, 8-4-4-4-12 format |
| `name` | string | Yes | Display name |
| `entryType` | string | Yes | `"infectious"`, `"husbandry"`, or `"medical"` |
| `alternateNames` | string[] | Yes | Can be `[]` |
| `imageAsset` | string \| null | Yes | Asset catalog name or `null` |
| `description` | string | Yes | Multi-line with bold headers (`"""` in Swift) |
| `toxicityInfo` | string | Yes | Multi-line with bold headers (`"""` in Swift) |
| `onsetTime` | object \| null | Yes | See OnsetTime below, or `null` |
| `symptoms` | string[] | Yes | Can be `[]` |
| `speciesRisks` | object[] | Yes | Can be `[]`. See SpeciesRisk below. |
| `preventionTips` | string[] \| null | Yes | `null` if none |
| `sources` | string[] | Yes | 1+ values |
| `relatedEntries` | string[] \| null | Yes | UUID strings or `null` |

### Fields omitted from diseases.json (hardcoded per platform)

| Field | Constant value | Where to hardcode |
|-------|---------------|-------------------|
| `categories` | `[.diseasesAndConditions]` | Loader adds it when parsing |
| `entrySeverity` | `nil` / `null` | Loader sets it to null |
| `toxicityInfoSectionTitle` | `"What makes it harmful?"` | UI constant per platform |

---

## Shared sub-objects

### OnsetTime

```json
{
  "early": "string or null",
  "delayed": "string or null"
}
```

Both fields are optional strings. At least one should be non-null if the object is present.

### SpeciesRisk

```json
{
  "species": "dog",
  "severity": "high",
  "notes": "string or null"
}
```

| Field | Type | Required |
|-------|------|----------|
| `species` | string | Yes |
| `severity` | string | Yes |
| `notes` | string \| null | Yes |

---

## Allowed enum values

### entrySeverity
`"low"` | `"lowModerate"` | `"moderate"` | `"high"` | `"severe"` | `null`

Uses Swift `rawValue` strings. `null` indicates an informational entry (no severity badge).
Each platform's UI layer can group `null`-severity entries into an "Informational" bucket
for browse views — this is a UI concern, not a data concern.

### categories
`"foods"` | `"plants"` | `"medications"` | `"cleaningProducts"` | `"garageGarden"` |
`"recreationalSubstances"` | `"holidayHazards"` | `"householdItems"` |
`"outdoorHazards"` | `"informational"`

Uses Swift `rawValue` strings. `"diseasesAndConditions"` is never stored in
`toxins.json` — it is implicit for all `diseases.json` entries.

### species
`"dog"` | `"cat"` | `"smallMammal"` | `"bird"` | `"reptile"`

### severity (in speciesRisks)
`"low"` | `"lowModerate"` | `"moderate"` | `"high"` | `"severe"`

Always non-null within a SpeciesRisk object.

### entryType (diseases.json only)
`"infectious"` | `"husbandry"` | `"medical"`

Replaces the iOS workaround of maintaining separate UUID sets
(`nonInfectiousEntryIDs`, `husbandryEntryIDs`). Each entry declares its own type.

---

## Cross-references

`relatedEntries` contains UUID strings that may reference entries in **either** file.
Both platforms should load both files, then resolve cross-references across the
combined set. Resolution failures (missing UUID) should be silently ignored —
an entry may reference a D&C entry that a free user can't access.

---

## Design decisions log

| Decision | Rationale |
|----------|-----------|
| Two files, not one | D&C entries have unique fields and omitted constants. Clean schemas > optional field soup. |
| `null` for informational severity | Matches iOS `Severity?` model. No fake `"informational"` enum value. |
| `entryType` per entry | Self-describing. Replaces fragile UUID-set classification. |
| Omit constant D&C fields | `categories`, `entrySeverity`, `toxicityInfoSectionTitle` are always identical — hardcode per platform. |
| Swift `rawValue` strings | iOS `Codable` decodes directly. Android uses matching enum names or `@SerializedName`. |
| `version` at root | Schema evolution without breaking parsers. |

---

## Migration plan

### Phase 1 — Extract to JSON (after v1.4 ships)
- Write extraction script to convert `DatabaseService.swift` and
  `DiseasesConditionsService.swift` to `toxins.json` and `diseases.json`
- Refactor iOS to load from JSON instead of hardcoded structs
- All future content edits happen in JSON files
- Validate: entry counts match, all UUIDs valid, cross-references resolve

### Phase 2 — Android MVP
- Android app reads the same JSON files bundled in assets
- Single source of truth — edit content once, both platforms get it

### Phase 3 — SQLite (future, optional)
- If search performance requires it, generate SQLite from JSON at build time
- JSON remains the source of truth; SQLite is a build artifact

---

*Finalized: Session 164, March 19, 2026*
