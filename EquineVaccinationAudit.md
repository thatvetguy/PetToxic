# Equine Edition — Vaccination Feature Audit

**Date:** February 17, 2026
**Source Repo:** `thatvetguy/PetToxicEquine`
**Purpose:** Document the vaccination tracking feature for adaptation to Pet Toxic (multi-species), and flag bugs for the Equine Edition.

---

## 1. Data Model

### VaccinationRecord (`Models/VaccinationRecord.swift`)

SwiftData `@Model` class with 5 fields:

| Field | Type | Notes |
|-------|------|-------|
| `id` | `UUID` | Auto-generated |
| `vaccineName` | `String` | From preset or custom |
| `dateAdministered` | `Date` | When vaccine was given |
| `nextDueDate` | `Date?` | Auto-calculated from preset intervals |
| `notes` | `String?` | Free-text |

### Relationship to Horse

- `VaccinationRecord.horse` → `Horse?` via `@Relationship(inverse: \Horse.vaccinationRecords)`
- `Horse.vaccinationRecords` → `[VaccinationRecord]` with `.cascade` delete rule
- Deleting a horse deletes all its vaccination records

### Storage

SwiftData. Registered in `EquineToxicApp.swift` line 23:
```swift
.modelContainer(for: [Horse.self, PoisonControlCase.self, VaccinationRecord.self, CareRecord.self, WeightRecord.self])
```

---

## 2. Preset Vaccines (`Models/EquinePresets.swift`)

12 vaccines in a `VaccinePreset` struct, split into two categories:

| Category | Vaccine | Booster Interval |
|----------|---------|-----------------|
| **Core** | Tetanus | 365 days |
| **Core** | Eastern/Western Encephalomyelitis (EEE/WEE) | 365 days |
| **Core** | West Nile Virus | 365 days |
| **Core** | Rabies | 365 days |
| **Risk-Based** | Equine Influenza | 182 days |
| **Risk-Based** | Rhinopneumonitis (EHV-1/4) | 182 days |
| **Risk-Based** | Strangles | 365 days |
| **Risk-Based** | Botulism | 365 days |
| **Risk-Based** | Potomac Horse Fever | 365 days |
| **Risk-Based** | Equine Viral Arteritis | 365 days |
| **Risk-Based** | Anthrax | 365 days |
| **Risk-Based** | Rotavirus | 365 days |

Custom vaccine names are supported — users can toggle "Custom vaccine name" and type any name. Custom names default to a 365-day booster interval for status calculation.

---

## 3. Status Calculation (`EquinePresets.swift` → `VaccinationStatus`)

Computed enum — not stored in the model. Always recalculated from dates.

```
VaccinationStatus.compute(nextDueDate:dateAdministered:vaccineName:)
```

- Uses `nextDueDate` if available; otherwise falls back to preset interval added to `dateAdministered`
- `daysUntilDue < 0` → `.overdue` (red, xmark.circle.fill)
- `daysUntilDue <= 30` → `.dueSoon` (yellow, exclamationmark.triangle.fill)
- `daysUntilDue > 30` → `.current` (green, checkmark.circle.fill)

---

## 4. UI Structure

### Entry Points (2 paths to the vaccination log)

1. **Home screen** → `MyHorsesHomeSection` → `HorseExpandedCard` → tap vaccination summary → opens `VaccinationLogView` as a `.sheet`
2. **Horse profile** → `HorseFormView` → "Health Records" section → `NavigationLink` to `VaccinationLogView`

### Views

| View | File | Purpose |
|------|------|---------|
| `VaccinationSummaryCard` | `Views/MyHorses/VaccinationSummaryCard.swift` | Compact card: current/due-soon/overdue pill counts |
| `VaccinationLogView` | `Views/MyHorses/VaccinationLogView.swift` | Full record list with add/edit/delete |
| `AddVaccinationSheet` | `Views/MyHorses/VaccinationLogView.swift:159` | Sheet for adding a new vaccination |
| `EditVaccinationSheet` | `Views/MyHorses/VaccinationLogView.swift:259` | Sheet for editing an existing vaccination |

### Add Flow

1. Tap `+` in toolbar → `AddVaccinationSheet` opens
2. Pick from preset vaccines (Picker with `.navigationLink` style) OR toggle "Custom vaccine name" and type
3. Date administered defaults to today
4. Next due date auto-calculates via `recomputeNextDue()` — updates live on `onChange` of vaccine/date/toggle
5. Optional notes field (3–6 lines)
6. Save inserts into SwiftData and appends to `horse.vaccinationRecords`

### Edit Flow

1. Tap any row → `EditVaccinationSheet` opens pre-populated
2. Changing the vaccine name triggers a confirmation alert
3. All fields are editable
4. Save updates the record in-place

### Delete Flow

- Standard swipe-to-delete (`.onDelete` modifier)

### Row Layout

- Vaccine name (headline) + status badge (icon + colored label) on right
- Date administered + "Due [date]" below
- Notes (if any, 2-line limit)

### Summary Card Layout

- Syringe icon + "Vaccinations" header
- Status pill counts: "3 Current", "1 Due Soon", "2 Overdue" (non-zero only)
- "No records" italic text if empty
- Groups by vaccine name, keeps only most recent record per vaccine for counts

---

## 5. Reminders / Notifications

**There are no push notifications or local notifications.** No `UNUserNotificationCenter` usage anywhere.

The only "reminder" mechanism is the visual status indicators (color-coded overdue/due-soon badges) visible when the user actively views their horse's records or the home screen expanded card.

---

## 6. Species-Specific Logic

**None.** The vaccine list is 100% hardcoded for horses. There is no species parameter, no species-based filtering, no abstraction layer.

---

## 7. Files Involved

| File | Path | Role |
|------|------|------|
| VaccinationRecord.swift | `Models/VaccinationRecord.swift` | SwiftData model |
| Horse.swift | `Models/Horse.swift` | Parent model, owns relationship |
| EquinePresets.swift | `Models/EquinePresets.swift` | Preset vaccines, VaccinePreset struct, VaccinationStatus enum, interval lookup |
| VaccinationLogView.swift | `Views/MyHorses/VaccinationLogView.swift` | Main list + Add/Edit sheets |
| VaccinationSummaryCard.swift | `Views/MyHorses/VaccinationSummaryCard.swift` | Compact summary card |
| HorseFormView.swift | `Views/MyHorses/HorseFormView.swift` | Profile form; NavigationLink to log in healthRecordsSection |
| MyHorsesHomeSection.swift | `Views/Components/MyHorsesHomeSection.swift` | Home screen; expanded card links to log via sheet |
| EquineToxicApp.swift | `App/EquineToxicApp.swift` | Registers VaccinationRecord in model container |

---

## 8. Bugs to Fix in Equine Edition

### BUG 1: Potential Double-Insert on Save (High Priority)

**File:** `VaccinationLogView.swift`, `AddVaccinationSheet.save()` (lines 249–251)

```swift
record.horse = horse          // sets the relationship
modelContext.insert(record)   // inserts into SwiftData
horse.vaccinationRecords.append(record)  // appends to relationship array
```

Both `modelContext.insert(record)` AND `horse.vaccinationRecords.append(record)` are called. In SwiftData, setting the relationship or appending to the parent's array should handle the insert automatically. This could create duplicate records.

**Fix:** Remove either `modelContext.insert(record)` or `horse.vaccinationRecords.append(record)` — one is redundant. The safest approach is to keep `horse.vaccinationRecords.append(record)` (which sets the relationship and inserts) and remove the explicit `modelContext.insert(record)`.

---

### BUG 2: Fragile Name-Change Guard in Edit Sheet (Medium Priority)

**File:** `VaccinationLogView.swift`, `EditVaccinationSheet` (lines 281–291)

```swift
.onChange(of: vaccineName) { oldValue, newValue in
    if oldValue != record.vaccineName && !oldValue.isEmpty {
        return  // "Already changed once, allow further edits freely"
    }
    if newValue != record.vaccineName && !newValue.isEmpty {
        pendingName = newValue
        vaccineName = oldValue   // reverts the change
        showingNameChangeAlert = true
    }
}
```

Problems:
- The "already changed once" bypass relies on `oldValue != record.vaccineName`, but if SwiftUI coalesces `onChange` calls during rapid typing, `oldValue` may not reflect the expected state.
- Reverting `vaccineName = oldValue` inside `onChange(of: vaccineName)` triggers another `onChange` call, creating a re-entrant loop. SwiftUI may handle this gracefully, but it's fragile.
- If the user cancels the alert, `vaccineName` stays at `oldValue` — but there's no mechanism to re-trigger the alert if they try again (the condition `oldValue != record.vaccineName` might already be true from the revert cycle).

**Fix:** Replace the `onChange` guard with a simpler pattern: let the user edit freely, and show the warning alert on Save if the name has changed from the original `record.vaccineName`.

---

### BUG 3: No Date Validation (Low Priority)

**File:** `VaccinationLogView.swift`, both Add and Edit sheets

Users can set `nextDueDate` before `dateAdministered` with no guard. This produces nonsensical records (e.g., administered Jan 2026, due Dec 2025).

**Fix:** Add a validation check: either prevent `nextDueDate < dateAdministered` in the `DatePicker` range, or show a warning. Simplest approach: set `in: dateAdministered...` on the next due date picker.

---

### BUG 4: Inconsistent Navigation Patterns (Low Priority)

**Files:** `HorseFormView.swift` (line 647), `MyHorsesHomeSection.swift` (line 418)

The vaccination log is reached via two different patterns:
- `HorseFormView` → `NavigationLink` (pushes onto nav stack)
- `HorseExpandedCard` → `Button` + `.sheet` (modal presentation)

This means the same `VaccinationLogView` appears as a pushed view in one context and a modal sheet in another. The sheet presentation adds its own "Done" button via toolbar, but the navigation link version relies on the back button. This is intentional design (the expanded card is already inside a sheet), but worth noting for consistency testing.

**Not necessarily a bug** — but worth verifying both paths work correctly, especially the toolbar button conflicts.

---

## 9. Adaptation Notes for Pet Toxic (Multi-Species)

### What Needs to Change

| Component | Current (Equine) | Needed for Pet Toxic |
|-----------|-------------------|---------------------|
| `EquinePresets.vaccines` | 12 horse-specific vaccines | Species-keyed vaccine lists |
| `VaccinePreset` struct | `name`, `category`, `intervalDays` | Add `species: [Species]` field |
| `VaccinationRecord` | Linked to `Horse` | Linked to a generic `Pet` model |
| `VaccinationStatus.compute()` | Falls back to `EquinePresets.presetInterval()` | Species-aware interval lookup |
| Picker UI | Single flat list of all presets | Filter by pet's species |

### Suggested Vaccine Presets by Species

- **Dogs:** Rabies, DHPP (Distemper/Hepatitis/Parvo/Parainfluenza), Bordetella, Leptospirosis, Canine Influenza, Lyme Disease
- **Cats:** Rabies, FVRCP (Rhinotracheitis/Calicivirus/Panleukopenia), FeLV, FIV
- **Small Mammals:** Rabbits: RHDV2, Myxomatosis (regional); Ferrets: Canine Distemper, Rabies; others: typically none
- **Birds:** Polyomavirus (psittacines); most pet birds have no standard vaccines
- **Reptiles:** No standard vaccines

### Code Volume

The feature is compact:
- ~350 lines of view code (2 view files)
- ~25 lines for the model
- ~50 lines for presets and status computation

---

*Generated by Claude Code — Session 124B*
