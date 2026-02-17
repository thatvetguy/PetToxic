# Pet Toxic — Entry Format Reference

Complete reference for how toxicity entries are built in Pet Toxic.

---

## ToxicItem Field Reference

Every entry is a `ToxicItem` struct. Fields must appear in this exact initializer order:

| # | Field | Type | Required | Description |
|---|-------|------|----------|-------------|
| 1 | `id` | `UUID` | Yes | Stable UUID. Never change after creation — affects bookmarks, history, cross-references. Use `UUID(uuidString: "...")!` |
| 2 | `name` | `String` | Yes | Display name. Don't change — affects search and navigation |
| 3 | `alternateNames` | `[String]` | Yes | Synonyms, brand names, common misspellings for searchability |
| 4 | `categories` | `[Category]` | Yes | One or more categories. Entries can be cross-listed |
| 5 | `imageAsset` | `String?` | No | Asset catalog name for thumbnail image (e.g., `"chocolate_thumb"`) |
| 6 | `description` | `String` | Yes | What the substance is, where it's found, why it matters |
| 7 | `toxicityInfo` | `String` | Yes | How/why it's toxic. Plain language with mechanism explanations |
| 8 | `onsetTime` | `OnsetTime?` | No | Early and delayed symptom timelines |
| 9 | `symptoms` | `[String]` | Yes | Observable signs owners might see (not diagnoses) |
| 10 | `entrySeverity` | `Severity?` | No | Overall entry severity. `nil` for informational entries |
| 11 | `speciesRisks` | `[SpeciesRisk]` | Yes | Per-species severity and notes. **Must include all 5 species** |
| 12 | `preventionTips` | `[String]?` | No | Practical prevention advice for pet owners |
| 13 | `sources` | `[String]` | Yes | Minimum 3 publicly accessible sources |
| 14 | `relatedEntries` | `[String]?` | No | Array of UUID strings for cross-referenced entries |

### OnsetTime

```swift
struct OnsetTime: Codable, Hashable {
    let early: String?    // When first symptoms appear
    let delayed: String?  // Later/progressive symptoms
}
```

### SpeciesRisk

```swift
struct SpeciesRisk: Codable, Hashable, Identifiable {
    let species: Species   // .dog, .cat, .smallMammal, .bird, .reptile
    let severity: Severity // Per-species severity level
    let notes: String?     // Species-specific clinical notes
}
```

---

## Complete Annotated Example Entry

This is the live Chocolate entry from `DatabaseService.swift`, annotated:

```swift
ToxicItem(
    // FIELD 1: id — Stable UUID, never change
    id: UUID(uuidString: "d8c34930-fe78-414c-a182-49521dbfc266")!,

    // FIELD 2: name — Display name shown in lists and article header
    name: "Chocolate",

    // FIELD 3: alternateNames — Synonyms, brand names, misspellings for search
    alternateNames: [
        "cocoa",
        "cacao",
        "dark chocolate",
        "milk chocolate",
        "baking chocolate",
        "white chocolate",
        "cocoa powder",
        "chocolate chips",
        "brownie",
        "brownies",
        "fudge",
        "hot cocoa",
        "hot chocolate",
        "chocolate cake",
        "chocolate bar",
        "choclate",       // <-- intentional misspelling for search
        "coco"            // <-- common shorthand
    ],

    // FIELD 4: categories — One or more. This entry is cross-listed
    categories: [.foods, .holidayHazards],

    // FIELD 5: imageAsset — Maps to Assets.xcassets/chocolate_thumb.imageset/
    imageAsset: "chocolate_thumb",

    // FIELD 6: description — What it is, where found, context
    description: "Chocolate is made from roasted cacao beans (Theobroma cacao—Greek for 'food of the gods') and is found in candy, baked goods, beverages, and desserts. It's one of the most common pet toxicities reported to poison control centers, with exposure spikes during holidays like Valentine's Day, Easter, Halloween, and Christmas. Dogs are particularly attracted to chocolate and can smell it even when wrapped or hidden.",

    // FIELD 7: toxicityInfo — How/why it's toxic, in plain language
    // Supports markdown bold (**text**) for section headers in longer entries
    // Supports paragraph breaks via \n\n (rendered with VStack spacing)
    toxicityInfo: "Chocolate contains theobromine and caffeine, both methylxanthines that affect the heart, nervous system, and muscles. Here's why chocolate is dangerous to pets: humans break down theobromine quickly (half-life of 6-10 hours), but dogs metabolize it very slowly (half-life of 17.5 hours). This means theobromine builds up in their system to toxic levels. Cats metabolize it even more slowly. These compounds overstimulate the heart (causing rapid or irregular heartbeat), excite the nervous system (causing restlessness, tremors, and seizures), and relax smooth muscle (contributing to vomiting and diarrhea). Toxicity risk varies significantly by chocolate type—darker and more bitter chocolates contain more theobromine and are far more dangerous. In order of risk: cocoa powder and cacao beans are most dangerous, followed by unsweetened baking chocolate, semisweet/dark chocolate and milk chocolate. White chocolate contains negligible theobromine and is not considered a chocolate toxicity risk — however, its high fat and sugar content can still trigger pancreatitis (see Fatty Foods & Grease).",

    // FIELD 8: onsetTime — Early and delayed symptom windows
    onsetTime: OnsetTime(
        early: "Caffeine effects begin within 30-60 minutes. Theobromine effects may take 2+ hours to appear. Initial signs include vomiting, restlessness, bloating, and increased thirst.",
        delayed: "Theobromine is metabolized slowly (17.5-hour half-life in dogs). Effects can persist for several days. Signs may progress to cardiac arrhythmias, seizures, and other serious complications."
    ),

    // FIELD 9: symptoms — Observable signs, not diagnoses
    symptoms: [
        "Vomiting",
        "Restlessness and hyperexcitability",
        "Bloating",
        "Increased thirst",
        "Rapid heart rate or abnormal heart rhythm",
        "Rapid breathing",
        "Elevated body temperature",
        "Muscle tremors or rigidity",
        "Seizures (severe cases)",
        "Very high doses: low blood pressure, slow heart rate, coma"
    ],

    // FIELD 10: entrySeverity — Overall severity (nil for informational)
    entrySeverity: .severe,

    // FIELD 11: speciesRisks — ALL 5 SPECIES REQUIRED
    speciesRisks: [
        SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are commonly affected due to indiscriminate eating habits. Hospitalization is often required for treatment."),
        SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are more sensitive to methylxanthines than dogs, though they rarely consume chocolate voluntarily."),
        SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are extremely sensitive to theobromine and caffeine due to their fast metabolism and small body size. Even tiny amounts of chocolate can be fatal. Documented deaths in parrots and mynah birds from small quantities of dark chocolate. Causes cardiac arrhythmias, seizures, and acute liver/kidney damage."),
        SpeciesRisk(species: .smallMammal, severity: .high, notes: "Rabbits, guinea pigs, hamsters, and other small mammals cannot efficiently metabolize theobromine. Even small amounts can cause digestive issues, cardiac problems, and potentially death. Keep all chocolate products away from small pets."),
        SpeciesRisk(species: .reptile, severity: .low, notes: "Limited data available. Reptiles are unlikely to consume chocolate voluntarily due to dietary preferences, but the methylxanthines in chocolate could potentially affect them if ingested. Avoid exposure as a precaution.")
    ],

    // FIELD 12: preventionTips — Practical owner advice
    preventionTips: [
        "Store all chocolate products in closed cabinets or high shelves out of pet reach",
        "Be especially vigilant during holidays—Valentine's Day, Easter, Halloween, and Christmas see the most chocolate exposures",
        "Educate children and guests not to share chocolate with pets or leave it within reach",
        "Remember that baking chocolate and dark chocolate are most dangerous—even small amounts can be serious",
        "Watch for counter-surfing dogs who may grab chocolate left on tables or counters",
        "Ask guests to keep purses and bags closed and off the floor—these often contain chocolate",
        "Place advent calendars and holiday candy dishes well above pet height",
        "White chocolate is not a theobromine toxicity risk, but its high fat and sugar content can trigger pancreatitis — the concern is the fat, not the chocolate"
    ],

    // FIELD 13: sources — Minimum 3, publicly accessible only
    sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "VCA Animal Hospitals"],

    // FIELD 14: relatedEntries — UUID strings, must be BIDIRECTIONAL
    relatedEntries: [
        "f2a3b4c5-6d7e-8f9a-0b1c-2d3e4f5a6b7c",  // Cocoa Mulch - same methylxanthine toxicity
        "ae80bf97-0ffd-4ed8-b9d9-727e747d583b",  // Caffeine - same methylxanthine toxicity
        "2e094121-64ea-499c-bfb4-6db98f139b55"   // Fatty Foods & Grease - white chocolate pancreatitis risk
    ]
),
```

---

## Species

Every entry **must** include all 5 species in `speciesRisks`.

| Species | Raw Value | Display Name | Icon (SF Symbol) | Includes |
|---------|-----------|--------------|-------------------|----------|
| `.dog` | `"dog"` | Dogs | `dog` | All domestic dogs |
| `.cat` | `"cat"` | Cats | `cat` | All domestic cats |
| `.smallMammal` | `"smallMammal"` | Small Mammals | `hare` | Rabbits, guinea pigs, hamsters, rats, mice, ferrets, chinchillas, gerbils |
| `.bird` | `"bird"` | Birds | `bird` | Budgies, canaries, parrots, macaws, cockatiels, finches |
| `.reptile` | `"reptile"` | Reptiles | `lizard` | Snakes, lizards, turtles, tortoises, bearded dragons, geckos |

**Sort order:** Dog → Cat → Small Mammal → Bird → Reptile

**Research notes:**
- Small mammals: research rabbits, guinea pigs, AND rodents separately (sensitivities vary)
- Birds: consider both small (budgies) and large (parrots) — small birds are often more sensitive
- Reptiles: research snakes, lizards, AND chelonians separately if needed

---

## Severity Levels

| Level | Raw Value | Display | Color (RGB) | Description | Sort Order |
|-------|-----------|---------|-------------|-------------|------------|
| `.low` | `"low"` | Low | `(144, 238, 144)` green | Mild GI upset possible; monitor at home | 1 |
| `.lowModerate` | `"lowModerate"` | Low-Moderate | `(255, 222, 50)` yellow | May cause mild to moderate effects; monitor closely | 2 |
| `.moderate` | `"moderate"` | Moderate | `(255, 215, 0)` gold | Vet consultation recommended | 3 |
| `.high` | `"high"` | High | `(255, 165, 0)` orange | Seek veterinary care promptly | 4 |
| `.severe` | `"severe"` | Severe | `(255, 68, 68)` red | Potentially life-threatening; emergency care needed | 5 |
| `nil` | — | — | Gray | Informational/educational content (no toxicity severity) | 0 |

**Sort behavior:** Entries sort highest severity first: SEVERE → HIGH → MODERATE → LOW-MODERATE → LOW → nil

**When to use `nil`:** Informational/umbrella entries, mechanical hazards (not chemical toxicosis). Examples: Rodenticides (umbrella), Corn Cob (mechanical obstruction), Linear Foreign Bodies.

---

## Categories

| Category | Raw Value | Display Name | Icon (SF Symbol) |
|----------|-----------|--------------|-------------------|
| `.foods` | `"foods"` | Foods | `fork.knife` |
| `.plants` | `"plants"` | Plants | `leaf.fill` |
| `.medications` | `"medications"` | Medications | `pills.fill` |
| `.cleaningProducts` | `"cleaningProducts"` | Cleaning Products | `bubbles.and.sparkles` |
| `.garageGarden` | `"garageGarden"` | Garage & Garden | `wrench.and.screwdriver.fill` |
| `.recreationalSubstances` | `"recreationalSubstances"` | Recreational Substances | `smoke.fill` |
| `.holidayHazards` | `"holidayHazards"` | Holiday Hazards | `gift.fill` |
| `.householdItems` | `"householdItems"` | Household Items | `house.fill` |
| `.outdoorHazards` | `"outdoorHazards"` | Outdoor Hazards | `figure.hiking` |
| `.informational` | `"informational"` | Informational | `info.circle.fill` |

**Cross-listing:** Entries can appear in multiple categories. Example: Chocolate is in both `.foods` and `.holidayHazards`. Informational entries include `.informational` and may also be cross-listed with their topical category.

---

## Cross-References (relatedEntries)

- `relatedEntries` is an array of UUID strings (not UUID objects)
- **All cross-references must be BIDIRECTIONAL** — if Entry A links to Entry B, Entry B must link back to Entry A
- Include a trailing comment identifying the target entry and the reason for the link

**Common cross-reference patterns:**
- Umbrella → Specific (Rodenticides → Bromethalin, Anticoagulant Rodenticides, etc.)
- Same toxic mechanism (Cocoa Mulch ↔ Chocolate — both methylxanthines)
- Combined products (Fertilizers ↔ Herbicides — "weed and feed" combos)
- Same-class substances (Caffeine ↔ Chocolate — both methylxanthines)

**Format:**
```swift
relatedEntries: [
    "uuid-string-here",  // Entry Name - reason for link
    "uuid-string-here"   // Entry Name - reason for link
]
```

---

## Glossary Term Linking

Glossary terms are **automatically detected and highlighted** in entry content — no manual tagging required.

**How it works:**
1. `GlossaryService.findTerms(in:)` scans `description` and `toxicityInfo` content
2. Matches are whole-word, case-insensitive against term names and `searchKeywords`
3. `GlossaryStyledText` renders the **first occurrence** of each matched term in **teal** color
4. Tapping a highlighted term opens the glossary definition

**What this means for entry authors:**
- Just write naturally. If you use a term like "methylxanthines," "hypoglycemia," "pancreatitis," or "ataxia," the glossary system will automatically detect and link it
- Use the jargon format `"technical term (plain language explanation)"` in entry text — the glossary link handles the deep definition, the parenthetical gives immediate context
- No special markup or tagging syntax needed

**Glossary term categories:** `.symptoms`, `.conditions`, `.mechanisms`, `.anatomy`, `.treatment`, `.medications`, `.general`

---

## Text Formatting in Entry Content

Both `description` and `toxicityInfo` support:

| Feature | Syntax | Rendering |
|---------|--------|-----------|
| Bold text | `**bold text**` | Rendered bold via AttributedString(markdown:) |
| Paragraph breaks | `\n\n` in single-line strings, or blank lines in `"""` multi-line strings | Rendered with 12pt spacing via VStack split |
| Glossary terms | Just write the term naturally | Auto-highlighted in teal |

**Multi-line string format** (preferred for long entries):
```swift
toxicityInfo: """
First paragraph with **bold headers** for visual structure.

Second paragraph separated by a blank line. This renders with visible spacing.

**IMMEDIATE ACTION:** Bold section headers help organize longer entries.
""",
```

**Single-line format** (for shorter entries):
```swift
toxicityInfo: "Content here with \\n\\n for paragraph breaks and **bold** for emphasis.",
```

**Important:** Do NOT use `\n\n` escape sequences inside `"""` multi-line blocks — the blank line already creates the paragraph break. Using both creates 4 newlines (redundant).

---

## Content Guidelines

### What to Include

- Practical examples ("Even a small amount can be dangerous to cats")
- Plain language explanations ("methemoglobinemia (a condition where blood cannot carry oxygen properly)")
- Observable symptoms — what owners might see (not diagnoses)
- Species-specific warnings
- Common exposure scenarios (helps with prevention)
- Common misspellings in `alternateNames` (improves searchability)
- Seasonal context (when exposures peak)
- Product identification tips (colors, packaging)
- "Pet-safe" product cautions (marketing claims vs. reality)

### Prohibited Content — Never Include

| Prohibited | Reason |
|-----------|--------|
| Dosage thresholds (mg/kg) | Implies safe amounts exist |
| LD50 data | Laypersons don't understand; implies thresholds |
| "Safe amount" language | Never imply any quantity is safe |
| "Generally well tolerated" | Could discourage seeking care |
| Prognosis statements ("prognosis is excellent/poor") | Depends on many factors |
| Treatment protocols | Constitutes medical advice |
| Instructions to induce vomiting | Medical advice; dangerous if done incorrectly |
| Medication recommendations | Medical advice |
| Specific doctor/author names | Use organization names only |

### Permitted First Aid

| Permitted | Example |
|-----------|---------|
| Bathing/rinsing | "Bathe to remove substance from fur" |
| Eye rinsing | "Rinse eyes with clean water or saline" |
| Remove from exposure | "Move pet to fresh air" |
| Karo syrup | For expected hypoglycemia (xylitol, diabetes meds) |

---

## Source Rules

**Minimum:** 3 publicly accessible sources per entry

**Preferred sources (in priority order):**
1. ASPCA Animal Poison Control Center
2. Pet Poison Helpline
3. Merck Veterinary Manual
4. Peer-reviewed journals (JAVMA, JVIM, JVECC)
5. Veterinary school websites (UC Davis, Cornell, Purdue)
6. Veterinary Partner
7. VCA Animal Hospitals, PetMD

**Restrictions:**
- **REMOVE** "Veterinary Information Network (VIN)" or "VIN" monograph sources (subscription-only, not publicly accessible)
- **KEEP** "Veterinary Partner" (VIN's public-facing website — acceptable)

---

## Thumbnail / Image Asset Setup

Images are stored in the Xcode asset catalog and referenced by the `imageAsset` field.

**Naming convention:** `[substance]_thumb` (e.g., `chocolate_thumb`, `lead_thumb`, `daffodil_thumb`)

**Asset catalog structure:**
```
PetToxic/Resources/Assets.xcassets/
├── chocolate_thumb.imageset/
│   ├── chocolate_thumb.png    (the actual image file)
│   └── Contents.json          (Xcode metadata)
├── grapes_thumb.imageset/
│   ├── grapes_thumb.png
│   └── Contents.json
└── ... (178+ image sets)
```

**How images load at runtime:**
```swift
// ArticleDetailView.swift
if let imageAsset = item.imageAsset {
    Image(imageAsset)         // Loads by asset catalog name
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
} else {
    // Fallback: category icon as placeholder
    Image(systemName: item.categories.first?.icon ?? "questionmark.circle")
}
```

**If `imageAsset` is `nil`:** The article view falls back to a category SF Symbol icon.

**All images are AI-generated** — the disclaimer explicitly states this.

---

## Disclaimer Text

The disclaimer appears at the top of every article view. It is expandable — collapsed shows a one-line summary, expanded shows the full text.

**Collapsed (always visible):**
> For educational purposes only. Not veterinary advice. Images AI-generated.

**Expanded (full text, 3 paragraphs):**

> This information is for educational purposes only and does not constitute veterinary medical advice. If your pet has been exposed to a potentially toxic substance, contact a licensed veterinarian or animal poison control center immediately.
>
> This database covers common toxic substances but is not a comprehensive listing of all possible hazards. The absence of a substance from this app should not be interpreted as an indication of safety. When in doubt, contact a veterinarian or animal poison control center.
>
> Images are AI-generated for illustration only and should not be used to identify real-world plants, substances, or products. Any resemblance to specific commercial brands is coincidental and unintentional.

---

## Emergency Contact Numbers

| Contact | Phone | Note |
|---------|-------|------|
| ASPCA Animal Poison Control | (888) 426-4435 | Consultation fee may apply |
| Pet Poison Helpline | (855) 764-7661 | Consultation fee may apply |

These are displayed as tappable call buttons (red background, phone icon) on the Emergency tab and in article views.

---

## Informational Entries

Entries describing mechanical hazards (not chemical toxicosis) or umbrella/educational content:

| Setting | Value |
|---------|-------|
| `entrySeverity` | `nil` |
| `categories` | Include `.informational` (can be cross-listed) |

**Examples:** Rodenticides (umbrella), Corn Cob (mechanical obstruction), Fruit Pits (choking/obstruction), Expanding Glues (mechanical), Linear Foreign Bodies, Calcium Oxalate Plants (umbrella).

---

*Generated from live codebase — February 2026*
