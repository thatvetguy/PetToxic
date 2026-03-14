# Pet Toxic — Diseases & Conditions Entry Template
## Content & Format Reference for Claude Code Sessions

*Created: Session 142 — March 2026*

---

## Overview

The **Diseases & Conditions** category is a Pro-locked feature covering infectious diseases,
non-infectious conditions, husbandry-related disorders, and nutritional/metabolic diseases
affecting companion animals. These entries are distinct from toxin entries and follow a
different content structure.

**Key distinctions from toxin entries:**
- Content is more educational and comprehensive — this is a paid Pro feature with a
  higher content quality bar than free toxin entries
- Includes disease mechanism, transmission, prevention, geographic context, and
  treatment goals
- Still strictly avoids constituting veterinary medical advice (see prohibited content below)
- Not all fields apply to every entry type — see Entry Types below

---

## Entry Types

### Type 1: Infectious Disease
Caused by a pathogen (virus, bacterium, parasite, fungus).

**Applies to:** Rabies, Canine Parvovirus, Feline Panleukopenia, Leptospirosis,
Psittacosis, Myxomatosis, Kennel Cough, Aspergillosis, FIP, PBFD, Cryptosporidiosis, etc.

**Required content blocks:**
- What the disease is + life-threatening potential
- Disease mechanism (how it harms the body)
- Transmission route(s)
- How spread is prevented
- Vaccine availability (if applicable)
- Geographic distribution / at-risk populations
- Incubation period
- Treatment goals (not protocols)

### Type 2: Non-Infectious Condition / Husbandry Disorder
Caused by environmental, nutritional, or husbandry factors (not a pathogen).

**Applies to:** Metabolic Bone Disease, Thermal Burns, Dysecdysis, Hypovitaminosis A,
GI Stasis, Dental Disease, Cushing's Disease, Hypothyroidism, etc.

**Required content blocks:**
- What the condition is + acute vs. chronic classification
- How the condition develops / what causes it
- At-risk species and populations
- Husbandry / environmental factors
- Prevention / management goals
- Treatment goals

---

## Field-by-Field Protocol

### `name`
- Use the full clinical name as the primary name
- Include the common name in parentheses if widely used
  - ✅ `"Canine Parvovirus (Parvo)"`
  - ✅ `"Psittacosis (Parrot Fever)"`
- Species qualifiers should be included where relevant to avoid confusion
  - ✅ `"Canine Parvovirus"` (not just "Parvovirus" — avoid confusion with feline equivalent)

---

### `alternateNames`
- Include all common names, abbreviations, and lay terms
- Include common misspellings for search coverage
- Include species-specific variants if relevant

**Example (Parvovirus):**
```
["parvo", "parvovirus", "CPV", "CPV-2", "canine parvo", "puppy parvo", "parvoviral enteritis"]
```

---

### `description` → Renders as **"What is it?"**

Cover all of the following:
1. **What it is** — brief definition in plain language
2. **Acute vs. chronic** — is this a sudden/rapid illness or a long-term condition?
3. **Life-threatening potential** — is this potentially fatal? State this clearly.
4. **Infectious or not** — state clearly if caused by a pathogen
5. **Vaccine-preventable** — yes/no (for infectious diseases only)
6. **Who is most at risk** — species, age groups, immune status, breed predispositions

**Tone:** Informative, clear, appropriately serious. Do not downplay severity.
Do not use survival rate percentages.

**Approved severity language (use instead of percentages):**
- "Can be fatal without prompt veterinary care"
- "Life-threatening, particularly in young or unvaccinated animals"
- "Carries a guarded to grave prognosis without aggressive treatment"
- "Outcomes are significantly better with early veterinary intervention"
- "Can progress rapidly — delays in treatment worsen outcomes"
- "Most animals survive with prompt, aggressive veterinary treatment" — acceptable
  because it emphasizes that treatment is required; always pair with a statement
  about the consequences of delayed or absent treatment (e.g., "...but outcomes
  worsen significantly without it")

**NOT permitted:**
- "Mortality rate is X%" — omit specific numbers
- "Prognosis is good/excellent" — never state prognosis as a standalone statement

---

### `toxicityInfo` → Renders as **"What makes it harmful?"**

This field carries the bulk of the clinical content. For Diseases & Conditions entries,
it covers three (or four) sections in order. Always use `"""` multi-line string format
with bold markdown headers to visually separate sections — these entries are long enough
that unbroken text is hard to read.

**Standard Swift format:**
```swift
toxicityInfo: """
**How It Harms the Body**
[mechanism content]

**Transmission & Spread**
[transmission content — infectious entries only]

**Treatment Goals**
[treatment goals content]

**Zoonotic Risk**
[zoonotic content — only for zoonotic diseases]
""",
```

**Header naming rules:**
- Use **"How It Harms the Body"** (plain language) — not "Disease Mechanism"
- Use **"Transmission & Spread"** — omit entirely for non-infectious conditions
- Use **"Treatment Goals"** — always included
- Use **"Zoonotic Risk"** — only when the disease is transmissible to humans; placed last
  so it stands out visually
- Do not add colons after bold headers (consistent with existing app entries)

#### Section 1: How It Harms the Body
- How the pathogen or condition harms the body
- What organ systems or tissues are affected
- Why the condition is dangerous — the biological reason
- Plain language with jargon explained in parentheses
  - ✅ "sepsis (a life-threatening whole-body infection)"
  - ✅ "bone marrow suppression (impaired ability to produce blood cells)"

#### Section 2: Transmission & Spread (Infectious entries only)
- How the disease is contracted (direct contact, fomites, vectors, aerosol, etc.)
- How it spreads between animals or from animals to humans (zoonotic potential)
- Environmental resilience where relevant (e.g., parvo surviving months on surfaces)
- Geographic distribution and at-risk regions
- High-risk settings (kennels, shelters, dog parks, bird markets, etc.)
- **Omit this section entirely for non-infectious conditions**
  (e.g., Metabolic Bone Disease, Dysecdysis — no transmission section needed)

#### Section 3: Treatment Goals
- Placed after mechanism (and transmission if present)
- Describe the **goals** of treatment only — not how they are achieved
- Do not name specific medications, dosing regimens, or treatment protocols
- Use a brief lead-in sentence, then a short list of goals

**Approved treatment goal framing:**
```
Veterinary treatment focuses on [goal 1], [goal 2], and [goal 3].
Early veterinary intervention significantly improves outcomes.
```

**Example (Parvovirus):**
```
Veterinary treatment focuses on restoring and maintaining hydration, controlling
nausea and vomiting, and preventing or treating secondary bacterial infections
(sepsis). A monoclonal antibody treatment has become available in recent years
that directly targets the parvovirus — this option is most effective when
administered early in the disease course.
```

**What NOT to include in treatment goals:**
- IV fluid rates or fluid types
- Antibiotic names or classes
- Antiemetic names or classes
- Hospitalization duration estimates
- Drug doses of any kind

#### Section 4: Zoonotic Risk (Zoonotic entries only)
- Only include for diseases transmissible to humans
- Keep brief — 2–3 sentences
- Direct owners to their own physician; do not describe severity in humans
- See **Zoonotic Disease Guidance** section below for approved language

---

### `toxicityInfoSectionTitle`
- **Always set to:** `"What makes it harmful?"`
- This applies to all Diseases & Conditions entries
- Never omit this field for disease entries (unlike toxin entries where it defaults)

```swift
toxicityInfoSectionTitle: "What makes it harmful?",
```

---

### `onsetTime`
Used to communicate the disease timeline to owners.

**For infectious diseases:**
- `early`: Incubation period + initial/prodromal signs
- `delayed`: Progressive/severe signs that develop after initial onset

**Format:**
```swift
onsetTime: OnsetTime(
    early: "Incubation period is [X–Y days/weeks]. Initial signs include [observable signs].",
    delayed: "[Progressive signs] develop within [timeframe]. Without prompt treatment, [consequence]."
),
```

**For non-infectious conditions:**
- `early`: When signs are first typically noticed
- `delayed`: How the condition progresses if untreated

**Note:** Incubation period should always be included for infectious disease entries.
This is useful, practical information for owners who suspect recent exposure.

---

### `symptoms`
- Observable signs owners might notice at home — not diagnoses
- Plain language; include medical term in parentheses where helpful
  - ✅ `"Yellowing of the skin or eyes (jaundice)"`
  - ✅ `"Difficulty breathing (labored or rapid breathing)"`
  - ✅ `"Seizures or uncontrolled muscle movements"`
- List from most common/early to most severe
- Do not include laboratory findings (e.g., "elevated liver enzymes") — owners cannot observe these

---

### `entrySeverity`
- Nearly all Diseases & Conditions entries will be `.severe` or `.high`
- Non-infectious chronic conditions may be `.moderate` if appropriate
- Use `nil` only for informational/umbrella entries (not currently anticipated in this category)

---

### `speciesRisks`
**Key difference from toxin entries:** Not all diseases affect all 5 species.

- **Include only species that are genuinely susceptible** to this specific disease/condition
- **Omit species** with no known susceptibility or where inclusion would be misleading
  - Example: Canine Parvovirus → Dogs only (no cat, bird, reptile, small mammal entries)
  - Example: Rabies → Dogs, Cats, Small Mammals (not birds or reptiles — extremely rare)
- For each included species, note:
  - Most vulnerable populations (age, immune status, breed)
  - Severity level appropriate to that species
  - Any species-specific clinical notes

**Approved species risk note framing:**
- "Most vulnerable in [age group / unvaccinated individuals / immunocompromised animals]"
- "Certain breeds may have higher susceptibility"
- "Life-threatening without prompt veterinary care" (instead of mortality %)
- "This disease does not naturally affect [species]" — use if clarification is helpful

---

### `preventionTips`
For infectious diseases, this section carries vaccination and exposure avoidance guidance.
For husbandry conditions, it covers environmental/management prevention.

**For infectious diseases — standard coverage:**
1. Vaccination: recommend following veterinarian's schedule; note if puppy/kitten series required
2. Exposure avoidance: unvaccinated animals, high-risk environments
3. Disinfection: if a specific agent is known to be effective (e.g., bleach for parvo)
4. Isolation: of infected or suspected animals
5. Zoonotic risk note: if the disease is transmissible to humans, state this clearly
6. Post-recovery shedding: duration if known

**For husbandry conditions — standard coverage:**
1. Husbandry requirements that prevent the condition
2. Nutritional guidance (general — no specific product recommendations)
3. Veterinary checkup recommendations
4. Environmental setup guidance

---

### `sources`
- Minimum **3 publicly accessible sources** per entry
- Preferred source hierarchy (same as toxin entries):
  1. ASPCA Animal Poison Control / AVMA
  2. Merck Veterinary Manual
  3. Cornell, UC Davis, Purdue veterinary school websites
  4. Veterinary Partner (VIN's public site — acceptable)
  5. AAHA, AAFP, or other specialty guidelines
  6. Peer-reviewed journals (JAVMA, JVIM, JVECC, JAVRS)
  7. VCA Animal Hospitals, PetMD

**Important:** Do NOT cite "VIN" or "Veterinary Information Network" monographs —
these are subscription-only. VeterinaryPartner.com is the publicly accessible VIN
resource and is acceptable to cite.

---

### `relatedEntries`
- Cross-reference related entries using UUID strings (not UUID objects)
- All cross-references must be **bidirectional**
- Common cross-reference patterns for this category:
  - Disease ↔ Closely related disease (Canine Parvovirus ↔ Feline Panleukopenia)
  - Disease ↔ Relevant toxin entry (Leptospirosis ↔ Stagnant Water entry if added)
  - Umbrella ↔ Specific entries (if umbrella entries are added later)

---

## Prohibited Content

These rules apply to all entries, including Diseases & Conditions:

| Prohibited | Reason |
|-----------|--------|
| Mortality rate percentages | Risk of discouraging care if numbers seem low |
| "Prognosis is good/excellent/poor" | Depends on many individual factors |
| "Most animals recover" (standalone) | Only acceptable when paired with emphasis that treatment is required — e.g., "Most animals recover with prompt, aggressive veterinary treatment, but outcomes worsen significantly without it" |
| Specific drug names or drug classes | Constitutes medical advice |
| Treatment protocols or dosing | Constitutes medical advice |
| "Safe at home" monitoring guidance | Could delay necessary treatment |
| Specific doctor or author names | Use organization names only |
| LD50 data | Not applicable to disease entries but included for completeness |

---

## Expanded Content Permissions (vs. Toxin Entries)

These items are **permitted** in Diseases & Conditions entries but are less common
in toxin entries:

| Permitted | Example |
|-----------|---------|
| Zoonotic risk statements | "Leptospirosis can be transmitted to humans — take precautions when handling an infected animal" |
| Geographic distribution | "Most common in the UK; rare in North America" (Myxomatosis) |
| Vaccine schedule context | "Puppies require a series of vaccines, with boosters beginning at 6–8 weeks" |
| Environmental resilience | "The virus can survive on surfaces for months to years" |
| Monoclonal antibody mention | Use approved language (see below) |
| Incubation periods | Always include for infectious diseases |
| Post-recovery shedding periods | "Recovered animals may shed the virus for up to 6 weeks" |
| High-risk settings | "Kennels, shelters, dog parks, and pet stores are high-risk environments" |

---

## Zoonotic Disease Guidance

If a disease is zoonotic (transmissible from animals to humans), this must be clearly
stated — but framed to inform, not to alarm.

**Where to mention it:**
- Briefly in `description` ("This disease can also affect humans.")
- In more detail in `toxicityInfo` under the Transmission section
- In `preventionTips` with practical safe-handling guidance

**Approved zoonotic language:**

| Context | Approved Phrasing |
|---------|------------------|
| General statement | "This disease is zoonotic — it can be transmitted from animals to humans." |
| Handling guidance | "If your pet is suspected or confirmed to have [disease], take precautions when handling them and contact your own physician if you have concerns about your own exposure." |
| High-risk populations | "Individuals who are immunocompromised, pregnant, elderly, or very young may be at greater risk and should take extra precautions." |
| Prevention tip | "Wash hands thoroughly after handling an infected animal or any materials they have contacted." |

**Tone guidance:**
- State the fact clearly — do not bury or minimize it
- Direct owners to their own physician for personal health concerns (do not advise)
- Do not describe severity of disease in humans (not the scope of this app)
- Do not use alarming language ("deadly to humans", "fatal if untreated in people")
- The goal is: owners know the risk, know to take precautions, know where to get help

**Example (Leptospirosis):**
> "Leptospirosis is a zoonotic disease — it can be transmitted from infected animals
> to humans, primarily through contact with urine or urine-contaminated water. If your
> pet has been diagnosed with leptospirosis, take precautions when handling them and
> consult your own physician if you have concerns about your own exposure."

---

## Approved Language: Monoclonal Antibody Treatments

When referencing newer biologic treatments (e.g., the canine parvovirus monoclonal antibody):

> "A monoclonal antibody treatment has become available in recent years that directly
> targets [pathogen/disease]. This option is most effective when administered early
> in the disease course — another reason why prompt veterinary evaluation is essential."

**Do not:** name the specific product, manufacturer, or dosing.
**Do:** emphasize the early-intervention message.

---

## Swift Implementation Notes

```swift
// toxicityInfoSectionTitle — ALWAYS include for disease entries
toxicityInfoSectionTitle: "What makes it harmful?",

// onsetTime — ALWAYS include explicitly (even if nil, state nil)
onsetTime: OnsetTime(
    early: "...",
    delayed: "..."
),

// speciesRisks — only include genuinely susceptible species
// (unlike toxin entries which require all 5)
speciesRisks: [
    SpeciesRisk(species: .dog, severity: .severe, notes: "..."),
    // Omit .cat, .bird, .reptile, .smallMammal if not applicable
],

// UUID format — use proper random UUIDs for new entries
// The sequential 1D000001-... format was used for initial placeholders only
// New entries should use: UUID().uuidString generated fresh
```

---

## Entry Checklist

Before submitting any Diseases & Conditions entry for implementation:

- [ ] `name` includes species qualifier if needed to avoid confusion
- [ ] `alternateNames` includes common abbreviations and lay terms
- [ ] `description` covers: what it is, acute/chronic, life-threatening potential,
      vaccine status, most at-risk populations
- [ ] `toxicityInfo` covers: mechanism → transmission/spread (if infectious) → treatment goals
- [ ] `toxicityInfoSectionTitle` set to `"What makes it harmful?"`
- [ ] `onsetTime` includes incubation period (infectious) or onset timeline (conditions)
- [ ] `symptoms` are observable by owners, listed early-to-severe
- [ ] `speciesRisks` includes only genuinely susceptible species
- [ ] No mortality percentages or prognosis statements
- [ ] No specific drug names, doses, or treatment protocols
- [ ] `preventionTips` includes vaccination, exposure avoidance, disinfection (if relevant),
      zoonotic risk (if applicable)
- [ ] Minimum 3 publicly accessible sources; no VIN monograph sources
- [ ] If zoonotic: stated clearly in `description` and `toxicityInfo`; safe-handling
      guidance in `preventionTips`; physician referral included; tone is informative
      not alarming
- [ ] `relatedEntries` cross-references are bidirectional

---

*End of Template Document*
*Add to PetToxic project root folder for reference by Claude Code sessions.*
