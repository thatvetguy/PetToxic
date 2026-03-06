# PetToxic Database Audit Rules

Full reference for editing, auditing, and adding entries in `DatabaseService.swift`.

*Last updated: 2026-03-06 (Session 135)*

---

## Core Principles

1. **OFFLINE FIRST** — All data bundled with app. Users may be in emergencies without connectivity.
2. **NO MEDICAL ADVICE** — Never provide dosage calculations, treatment instructions, prognosis, or medication recommendations.
3. **ALWAYS DISCLAIM** — Every article view must display the legal disclaimer prominently.
4. **SPEED** — Information accessible within 2-3 taps.

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

## Severity Levels

| Level | Definition | UI Color | Recommendation |
|-------|------------|----------|----------------|
| `.severe` | Life-threatening | Red | Immediate emergency care |
| `.high` | Serious symptoms expected | Orange | Prompt veterinary care |
| `.moderate` | Significant symptoms possible | Yellow | Veterinary evaluation recommended |
| `.low` | Mild, self-limiting | Green | Monitor; contact vet if worsens |
| `nil` | Informational entry | Gray | Educational/umbrella content |

**Sorting:** Entries sort by severity (SEVERE -> HIGH -> MODERATE -> LOW -> nil).

---

## Sources

| Action | Rule |
|--------|------|
| **REMOVE** | "Veterinary Information Network (VIN)" or "VIN" monograph sources |
| **KEEP** | "Veterinary Partner" (VIN's public website -- acceptable) |
| **REQUIRE** | Minimum 3 publicly accessible sources per entry |

**Preferred sources (in order):**
1. ASPCA Animal Poison Control Center
2. Pet Poison Helpline
3. Merck Veterinary Manual
4. Peer-reviewed journals (JAVMA, JVIM, JVECC)
5. Veterinary school websites (UC Davis, Cornell, Purdue)
6. Veterinary Partner
7. VCA Animal Hospitals, PetMD

---

## Content to REMOVE

| Remove | Reason |
|--------|--------|
| VIN sources | Subscription-only; not publicly accessible |
| Dosage thresholds (mg/kg) | Implies safe amounts exist |
| LD50 data | Laypersons don't understand; implies thresholds |
| "Safe amount" language | Never imply any quantity is safe |
| "Generally well tolerated" | Could discourage seeking care |
| Prognosis statements | "Prognosis is excellent/poor" -- depends on many factors |
| Treatment protocols | Constitutes medical advice |
| Specific doctor/author names | Use organization names only |

---

## Content to KEEP or ADD

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

---

## Permitted First Aid

| Permitted | Example |
|-----------|---------|
| Bathing/rinsing | "Bathe to remove substance from fur" |
| Eye rinsing | "Rinse eyes with clean water or saline" |
| Remove from exposure | "Move pet to fresh air" |
| Karo syrup | For expected hypoglycemia (xylitol, diabetes meds) |

---

## Language Guidelines

- **Target audience:** Pet owners without medical training
- **Jargon format:** "technical term (plain language explanation)"
- **Use:** "Animal poison control" (not specific hotline names -- numbers listed separately)
- **Tone:** Informative but urgent; never dismissive of risk

---

## Cross-References (relatedEntries)

**All cross-references must be BIDIRECTIONAL.**

If Entry A links to Entry B, Entry B must link back to Entry A.

**Common cross-reference patterns:**
- Umbrella -> Specific entries (Rodenticides -> Bromethalin, Anticoagulants, etc.)
- Same toxic mechanism (Cocoa Mulch <-> Chocolate -- both methylxanthines)
- Combined products (Fertilizers <-> Herbicides -- "weed and feed")

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

## Categories

| Category | Key | Icon |
|----------|-----|------|
| Foods | `.foods` | `fork.knife` |
| Plants | `.plants` | `leaf.fill` |
| Medications | `.medications` | `pills.fill` |
| Cleaning Products | `.cleaningProducts` | `bubbles.and.sparkles` |
| Garage & Garden | `.garageGarden` | `wrench.and.screwdriver.fill` |
| Household Items | `.householdItems` | `house.fill` |
| Recreational Substances | `.recreationalSubstances` | `smoke.fill` |
| Outdoor Hazards | `.outdoorHazards` | `figure.hiking` |
| Informational | `.informational` | `info.circle.fill` |

**Cross-listing:** Entries can appear in multiple categories (e.g., Hops in Foods + Plants + Household Items).

---

## ToxicItem Initializer Field Order

When adding new entries, fields MUST appear in this exact order:

```
id, name, alternateNames, categories, imageAsset, description, toxicityInfo,
onsetTime, symptoms, entrySeverity, speciesRisks, preventionTips, sources,
relatedEntries
```

---

## Fields to EDIT During Audits

- `speciesRisks` -- Add missing species
- `sources` -- Remove VIN, ensure 3+ remain
- `toxicityInfo` / `description` -- Remove prohibited content, add plain language
- `relatedEntries` -- Add cross-references (bidirectional)
- `alternateNames` -- Add misspellings, brand names, synonyms
- `categories` -- Add cross-listings if appropriate
- `entrySeverity` -- Set to `nil` for informational entries

## Fields NOT to EDIT

- `id` (UUID) -- Breaking change; affects app functionality
- `name` -- Affects search and navigation
- `imageAsset` / `thumbnailURL` -- Linked to external assets; coordinate with user

---

## Audit Checklist

Before committing any entry edit, verify:

1. Are all 5 species present with severity + notes?
2. Is VIN removed from sources? Are 3+ sources remaining?
3. Is any "safe amount" language present that should be removed?
4. Are cross-references bidirectional?
5. Does the entry work offline? (All data must be bundled)
6. Could any content be construed as medical advice?

---

## Audit Progress

| Category | Entries | Status |
|----------|---------|--------|
| Plants | ~48 | Complete |
| Foods | ~17 | Complete |
| Medications | ~24 | Complete |
| Garage & Garden | ~21 | Complete |
| Household Items | ~15 | Complete |
| Cleaning Products | 9 | Complete |
| Recreational Substances | 6 | Complete |
| Outdoor Hazards | 12 | Complete |

*All 8 main categories audited.*
