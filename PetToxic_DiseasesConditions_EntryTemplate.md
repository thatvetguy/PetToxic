# Pet Toxic — Diseases & Conditions Entry Template
## Content & Format Reference for Claude Web & Claude Code Sessions

*Created: Session 142 — March 2026*
*Revised: Session 145 — March 2026 (Type system expanded; "Causes & Risk Factors" adopted as universal header; tone guidance decoupled from entry type)*

---

## Overview

The **Diseases & Conditions** category is a Pro-locked feature covering infectious diseases,
non-infectious conditions, husbandry-related disorders, and nutritional/metabolic diseases
affecting companion animals. These entries are distinct from toxin entries and follow a
different content structure.

**Key distinctions from toxin entries:**
- Content is more educational and comprehensive — this is a paid Pro feature with a
  higher content quality bar than free toxin entries
- Includes disease mechanism, causes/risk factors, prevention where applicable,
  geographic context, and treatment goals
- Still strictly avoids constituting veterinary medical advice (see prohibited content below)
- Not all fields apply to every entry type — see Entry Types below

---

## Entry Types

Entry types guide content decisions, section structure, and **sort order** in the
app. Within each species group, infectious diseases (Type 1) are listed first
(alphabetically), followed by non-infectious conditions (Type 2 / Type 3,
alphabetically). The type label itself is not displayed to the user.

**Implementation:** `DiseasesConditionsService.nonInfectiousEntryIDs` maintains
the set of non-infectious entry UUIDs. When adding a new Type 2 or Type 3 entry,
its UUID **must** be added to this set — otherwise it will sort as infectious.

---

### Type 1: Infectious Disease
Caused by a pathogen (virus, bacterium, parasite, fungus).

**Applies to:** Rabies, Canine Parvovirus, Feline Panleukopenia, Leptospirosis,
Psittacosis, Myxomatosis, Kennel Cough, Aspergillosis, FIP, PBFD,
Cryptosporidiosis, Canine Influenza, etc.

**`toxicityInfo` section structure:**
1. **How It Harms the Body** — pathogen mechanism, organ systems affected
2. **Transmission & Spread** — routes of infection, environmental resilience,
   geographic distribution, high-risk settings
3. **Treatment Goals** — goals only; no protocols, drug names, or dosing
4. **Zoonotic Risk** *(only if zoonotic)* — brief, informative, not alarming

**Tone:** Match the clinical course. Acute diseases (Parvovirus, Distemper) warrant
urgency. Chronic or insidious diseases (FIP, PBFD) warrant a more measured tone.
Never downplay severity regardless of pacing.

**`preventionTips` emphasis:** Vaccination, exposure avoidance, disinfection,
isolation of infected animals, zoonotic handling precautions where applicable.

---

### Type 2: Husbandry Condition
Caused primarily by environmental, nutritional, or husbandry deficiencies — not
a pathogen. Often preventable with correct husbandry. May be acute or chronic
depending on the condition.

**Applies to:** Metabolic Bone Disease (MBD), Dysecdysis (Abnormal Shedding),
Thermal Burns, Hypovitaminosis A, GI Stasis, Feather Destructive Behavior,
Hepatic Lipidosis (diet-driven), etc.

**`toxicityInfo` section structure:**
1. **How It Harms the Body** — what goes wrong physiologically and why
2. **Causes & Risk Factors** — the husbandry failures, nutritional gaps, or
   environmental deficiencies that drive the condition; at-risk species/setups
3. **Treatment Goals** — goals only; no protocols, drug names, or dosing

*(No Transmission & Spread section — these conditions are not contagious.)*
*(No Zoonotic Risk section — husbandry conditions do not transmit to humans.)*

**Tone:** Match the clinical course. Chronic husbandry conditions (MBD,
Dysecdysis) take an educational, slow-build tone — the goal is awareness and
prevention. Acute husbandry conditions (Thermal Burns) warrant urgency similar
to infectious entries.

**`preventionTips` emphasis:** This section carries the primary prevention
message for husbandry conditions. Cover: correct environmental setup, nutrition,
UVB/lighting, substrate, humidity, regular veterinary checkups. Be specific
enough to be actionable; do not recommend specific products by name.

---

### Type 3: Medical / Metabolic Condition
A disease process not caused by a pathogen and not primarily driven by husbandry
failures. May involve immune dysfunction, endocrine dysregulation, genetic
predisposition, idiopathic causes, or secondary disease processes. Prevention
ranges from limited to impossible; management is the primary focus.

**Applies to:** IMHA (Immune-Mediated Hemolytic Anemia), Diabetes Mellitus,
Cushing's Disease (Hyperadrenocorticism), Addison's Disease, Hypothyroidism,
Hyperthyroidism (cats), Renal Disease, Epilepsy, Degenerative Joint Disease,
Cardiac Disease, etc.

**`toxicityInfo` section structure:**
1. **How It Harms the Body** — what goes wrong physiologically and why
2. **Causes & Risk Factors** — known causes, triggers, breed predispositions,
   age/sex risk factors, idiopathic origin where applicable; avoid implying
   that all cases are owner-preventable
3. **Treatment Goals** — goals only; no protocols, drug names, or dosing

*(No Transmission & Spread section — these conditions are not contagious.)*
*(Zoonotic Risk: include only if a zoonotic component genuinely exists — rare
for this type.)*

**Tone:** Match the clinical course. Acute crises (diabetic ketoacidosis, IMHA
hemolytic crisis, Addisonian crisis) warrant urgency. Chronic progressive
conditions (renal disease, cardiac disease, hypothyroidism) warrant a measured,
monitoring-focused tone. Never imply that owner error caused the condition unless
a causal link is well-established.

**`preventionTips` emphasis:** For many Type 3 conditions, true prevention is
limited or impossible. Focus on: regular veterinary checkups for early detection,
breed-specific screening if applicable, weight management where relevant, avoiding
known triggers where they exist. Do not write prevention tips that imply blame
or that the owner could have prevented an idiopathic or genetic condition.

---

## "Causes & Risk Factors" — Universal Header for Non-Infectious Entries

For all **Type 2** and **Type 3** entries, the second section of `toxicityInfo`
uses the header **"Causes & Risk Factors"**. This replaces the entry-type-specific
language that was used in earlier drafts ("Husbandry Factors," "Risk Factors," etc.).

**Why this header works across all non-infectious types:**
- For husbandry conditions: covers UVB deficiency, dietary imbalance, improper
  enclosure, etc.
- For metabolic/medical conditions: covers breed predisposition, age, hormonal
  dysregulation, immune dysfunction, idiopathic origin
- It implies causes without implying prevention where prevention may not be
  realistic

**Header NOT used for:**
- Type 1 (Infectious): uses "Transmission & Spread" instead — causes are the
  pathogen, which is covered in "How It Harms the Body"

---

## Field-by-Field Protocol

### `name`
- Use the full clinical name as the primary name
- Include the common name in parentheses if widely used
  - ✅ `"Canine Parvovirus (Parvo)"`
  - ✅ `"Psittacosis (Parrot Fever)"`
  - ✅ `"Metabolic Bone Disease (MBD)"`
- Species qualifiers should be included where relevant to avoid confusion
  - ✅ `"Canine Parvovirus"` (not just "Parvovirus")

---

### `alternateNames`
- Include all common names, abbreviations, and lay terms
- Include common misspellings for search coverage
- Include species-specific variants if relevant

---

### `description` → Renders as **"What is it?"**

Cover all of the following:
1. **What it is** — brief definition in plain language
2. **Acute vs. chronic** — is this a sudden/rapid illness or a long-term condition?
3. **Life-threatening potential** — state this clearly; do not downplay
4. **Infectious or not** — state clearly if caused by a pathogen; state clearly
   if *not* contagious (reassures owners of husbandry/medical conditions)
5. **Vaccine-preventable** — yes/no (for infectious diseases only)
6. **Who is most at risk** — species, age groups, immune status, breed
   predispositions

**Tone:** Informative, clear, appropriately serious. Do not downplay severity.
Do not use survival rate percentages.

**Approved severity language:**
- "Can be fatal without prompt veterinary care"
- "Life-threatening, particularly in young or unvaccinated animals"
- "Carries a guarded to grave prognosis without aggressive treatment"
- "Outcomes are significantly better with early veterinary intervention"
- "Can progress rapidly — delays in treatment worsen outcomes"
- "Most animals survive with prompt, aggressive veterinary treatment" — acceptable
  only when paired with: "but outcomes worsen significantly without it"

**NOT permitted:**
- "Mortality rate is X%" — omit specific numbers
- "Prognosis is good/excellent" — never state prognosis as a standalone statement

---

### `toxicityInfo` → Renders as **"What makes it harmful?"**

Carries the bulk of clinical content. Use `"""` multi-line string format with
bold markdown headers. Always use bold headers — these entries are long and
unbroken text is hard to read.

**Standard Swift format:**

```swift
toxicityInfo: """
**How It Harms the Body**
[mechanism content]

**Transmission & Spread**
[Type 1 only — omit entirely for Type 2 and Type 3]

**Causes & Risk Factors**
[Type 2 and Type 3 only — omit for Type 1]

**Treatment Goals**
[always included]

**Zoonotic Risk**
[only for zoonotic diseases — placed last]
""",
```

**Header naming rules:**
- `**How It Harms the Body**` — always first; plain language, not "Disease Mechanism"
- `**Transmission & Spread**` — Type 1 only; omit entirely for Type 2 and Type 3
- `**Causes & Risk Factors**` — Type 2 and Type 3 only; omit for Type 1
- `**Treatment Goals**` — always included
- `**Zoonotic Risk**` — only when disease is transmissible to humans; always last
- Do not add colons after bold headers (consistent with all existing app entries)

#### Section: How It Harms the Body (All types)
- How the pathogen or condition harms the body
- What organ systems or tissues are affected
- Why the condition is dangerous — the biological reason
- Plain language with jargon explained in parentheses
  - ✅ "sepsis (a life-threatening whole-body infection)"
  - ✅ "demineralization (progressive loss of calcium from bone tissue)"
  - ✅ "hemolysis (destruction of red blood cells)"

#### Section: Transmission & Spread (Type 1 only)
- How the disease is contracted
- How it spreads between animals or from animals to humans
- Environmental resilience where relevant
- Geographic distribution and at-risk regions
- High-risk settings (kennels, shelters, dog parks, bird markets, etc.)
- **Omit this section entirely for Type 2 and Type 3 entries**

#### Section: Causes & Risk Factors (Type 2 and Type 3 only)
- For Type 2 (Husbandry): Husbandry failures, environmental deficiencies,
  nutritional gaps; be specific enough to be educational
- For Type 3 (Medical/Metabolic): Known causes, triggers, breed predispositions,
  age/sex risk factors; include "idiopathic" when cause is unknown
- Do not imply owner blame for conditions that are idiopathic or genetic
- At-risk species, life stages, or populations
- **Omit this section for Type 1 entries** (causes covered in "How It Harms the Body")

#### Section: Treatment Goals (All types)
- Describe the goals of treatment only — not how they are achieved
- Do not name specific medications, dosing regimens, or treatment protocols
- Use a brief lead-in sentence, then a short list of goals

**Approved treatment goal framing:**
```
Veterinary treatment focuses on [goal 1], [goal 2], and [goal 3].
Early veterinary intervention significantly improves outcomes.
```

**What NOT to include:**
- IV fluid rates or fluid types
- Antibiotic, antiemetic, or other drug names or classes
- Hospitalization duration estimates
- Drug doses of any kind

#### Section: Zoonotic Risk (Zoonotic entries only)
- Only include for diseases transmissible to humans
- Keep brief — 2–3 sentences
- Direct owners to their own physician; do not describe severity in humans
- See **Zoonotic Disease Guidance** section below for approved language

---

### `toxicityInfoSectionTitle`
- **Always set to:** `"What makes it harmful?"`
- Applies to all Diseases & Conditions entries
- Never omit this field for disease entries

```swift
toxicityInfoSectionTitle: "What makes it harmful?",
```

---

### `onsetTime`
Used to communicate the disease or condition timeline to owners.

**Guiding principle:** Match the real clinical course. Do not force all entries
into an incubation-period mold. The field should give owners a realistic sense
of how quickly or slowly to expect signs to appear and progress.

**For Type 1 (Infectious diseases):**
- `early`: Incubation period + initial/prodromal signs
- `delayed`: Progressive/severe signs that develop after initial onset

**For Type 2 (Husbandry conditions):**
- Chronic: `early`: "Develops gradually over weeks to months; early signs are
  often subtle or absent." `delayed`: How the condition presents once advanced.
- Acute (e.g., Thermal Burns): `early`: "Immediate at time of exposure."
  `delayed`: "Full extent of tissue damage may not be apparent for 24–72 hours."

**For Type 3 (Medical/Metabolic conditions):**
- Chronic: `early`: "Signs may develop gradually over weeks to months."
  `delayed`: How the condition progresses or decompensates if untreated.
- Acute crisis: `early`: "Can develop over days to weeks."
  `delayed`: "Crisis (e.g., hemolytic collapse, DKA) can develop rapidly once
  decompensated."

**Note:** Incubation period should always be stated for Type 1 entries —
practical information for owners who suspect recent exposure.

---

### `symptoms`
- Observable signs owners might notice at home — not diagnoses
- Plain language; include medical term in parentheses where helpful
  - ✅ `"Yellowing of the skin or eyes (jaundice)"`
  - ✅ `"Soft or rubbery bones; limb deformities"`
  - ✅ `"Seizures or uncontrolled muscle movements"`
- List from most common/early to most severe
- Do not include laboratory findings — owners cannot observe these

---

### `entrySeverity`
- Always `nil` for all Diseases & Conditions entries
- Species-level severity is set on each `SpeciesRisk`

```swift
entrySeverity: nil,
```

---

### `speciesRisks`
**Key difference from toxin entries:** Not all diseases affect all 5 species.

- **Include only species that are genuinely susceptible**
- **Omit species** with no known susceptibility or where inclusion would be
  misleading
- When omitting species, note the omission briefly in `description` or in a
  relevant species note:
  - ✅ "Birds and reptiles are not susceptible to rabies."
  - ✅ "Dogs and cats are rarely affected by metabolic bone disease."
- For each included species, note:
  - Most vulnerable populations (age, immune status, breed)
  - Severity level appropriate to that species
  - Any species-specific clinical notes

**Severity `.low` and species list visibility:**
Species with a `.low` severity rating are **excluded from that species'
category list** in the app. The entry will not appear under that species
group in the Diseases & Conditions browse view. The species risk data is
still present on the entry itself — it displays when the entry is opened
from another species group where the risk is higher.

Use `.low` when a species is technically susceptible but the clinical
significance is minimal (e.g., cats and Canine Influenza H3N2 — documented
but uncommon and typically mild). If a species has meaningful clinical risk,
use `.moderate` or higher so the entry appears in that species' list.

**Approved species risk note framing:**
- "Most vulnerable in [age group / unvaccinated / immunocompromised]"
- "Certain breeds may have higher susceptibility"
- "Life-threatening without prompt veterinary care"
- "This disease does not naturally affect [species]" — use where helpful

---

### `preventionTips`
Prevention content lives here — not in `toxicityInfo`. This keeps `toxicityInfo`
focused on mechanism, causes, and treatment goals.

**The depth and emphasis of preventionTips should reflect how preventable the
condition actually is:**

| Entry Type | Prevention emphasis |
|------------|---------------------|
| Type 1 — Infectious | Vaccination schedule, exposure avoidance, disinfection, isolation, zoonotic handling |
| Type 2 — Husbandry | Husbandry requirements, nutrition, UVB/lighting, environment setup, vet checkups — strong emphasis |
| Type 3 — Medical/Metabolic | Weight management, breed-specific screening, regular checkups, known trigger avoidance — realistic emphasis; do not imply owner blame for idiopathic/genetic conditions |

**For Type 2 (Husbandry conditions):** This is the most important section.
Be specific: name the husbandry requirements that directly prevent the condition
(e.g., "Provide appropriate UVB-B lighting — consult your exotic vet for species-
specific requirements"). Do not recommend specific products by name.

**For Type 3 (Medical/Metabolic conditions):** Avoid implying that the owner
could have prevented the condition if it is idiopathic or genetic. Focus on
monitoring and early detection.

---

### `sources`
- Minimum **3 publicly accessible sources** per entry
- Preferred source hierarchy:
  1. AVMA, ASPCA Animal Poison Control
  2. Merck Veterinary Manual
  3. Cornell, UC Davis, Purdue veterinary school websites
  4. Veterinary Partner (VIN's public site — acceptable)
  5. AAHA, AAFP, or other specialty organization guidelines
  6. Peer-reviewed journals (JAVMA, JVIM, JVECC, JAVRS)
  7. VCA Animal Hospitals, PetMD

**Important:** Do NOT cite "VIN" or "Veterinary Information Network" monographs —
subscription-only. VeterinaryPartner.com is the publicly accessible VIN resource.

---

### `relatedEntries`
- Cross-reference related entries using UUID strings (not UUID objects)
- All cross-references must be **bidirectional** — if this entry links to another,
  that entry must link back
- Common cross-reference patterns:
  - Disease ↔ Closely related disease (Canine Parvovirus ↔ Feline Panleukopenia)
  - Husbandry condition ↔ Related husbandry condition (MBD ↔ Hypovitaminosis A)
  - Disease ↔ Relevant toxin entry (Leptospirosis ↔ Stagnant Water if added)
  - Umbrella entry ↔ Specific entries

---

## Tone Guidance

**Tone is determined by clinical course — not by entry type.**

| Clinical course | Tone |
|-----------------|------|
| Acute, life-threatening (e.g., Parvovirus, IMHA crisis, Thermal Burns) | Urgent; emphasize rapid progression and need for immediate care |
| Chronic, gradual (e.g., MBD, Renal Disease, Hypothyroidism) | Educational; measured pace; emphasize early detection and prevention |
| Insidious, often asymptomatic early (e.g., FIP, PBFD) | Serious but not panicked; emphasize the importance of not dismissing subtle signs |
| Preventable (husbandry conditions) | Empowering; focus on what owners can do; avoid blame |
| Not preventable (idiopathic/genetic) | Informative; focus on monitoring; explicitly avoid implication of owner fault |

**Always:**
- State life-threatening potential clearly — do not minimize severity
- Direct owners to veterinary care — never suggest home management is sufficient
- Use the required disclaimer (displayed at entry top level, not in field content)

---

## Prohibited Content

These rules apply to all entries, including Diseases & Conditions:

| Prohibited | Reason |
|------------|--------|
| Mortality rate percentages | Risk of discouraging care if numbers seem low |
| "Prognosis is good/excellent/poor" as standalone statement | Depends on many individual factors |
| "Most animals recover" without pairing with treatment requirement | Could discourage seeking care |
| Specific drug names or drug classes | Constitutes medical advice |
| Treatment protocols or dosing | Constitutes medical advice |
| "Safe at home" monitoring guidance | Could delay necessary treatment |
| Specific doctor or author names | Use organization names only |
| Implying owner blame for idiopathic or genetic conditions | Inaccurate and harmful |

---

## Expanded Content Permissions (vs. Toxin Entries)

These items are **permitted** in Diseases & Conditions entries:

| Permitted | Example |
|-----------|---------|
| Zoonotic risk statements | "Leptospirosis can be transmitted to humans" |
| Geographic distribution | "Most common in the UK; rare in North America" (Myxomatosis) |
| Vaccine schedule context | "Puppies require a series of vaccines beginning at 6–8 weeks" |
| Environmental resilience | "The virus can survive on surfaces for months to years" |
| Monoclonal antibody mention | Use approved language (see below) |
| Incubation periods | Always include for Type 1 entries |
| Post-recovery shedding periods | "Recovered animals may shed the virus for up to 6 weeks" |
| High-risk settings | "Kennels, shelters, dog parks, and pet stores are high-risk environments" |
| Husbandry specifics | "Bearded dragons require UVB-B lighting to synthesize vitamin D3" |
| Breed predispositions | "German Shepherds and Belgian Malinois are overrepresented in IMHA cases" |

---

## Optional Content Blocks (Established in Prior Sessions)

These additional sections in `toxicityInfo` have been used successfully in prior
entries. Use them where clinically relevant and editorially strong:

### Myths vs. Facts *(Established: Rabies, Session 144)*
- Use for conditions with strong public misconceptions
- Placed at the end of `toxicityInfo` after all standard sections
- Format: bold **Myth:** / **Fact:** pairs
- Strong candidates: Rabies, Canine Influenza, IMHA, Epilepsy

### Hooks & Interesting Facts *(Established: Psittacosis, Session 144)*
- Use when historical context or surprising facts add meaningful educational value
- Placed as final bold-header section in `toxicityInfo`
- Should feel like a natural addition, not a padding exercise
- Strong candidates: Psittacosis (1929 pandemic), Myxomatosis (bioweapon history),
  Leptospirosis (trench fever link), Metabolic Bone Disease ("almost entirely
  preventable" hook)

---

## Zoonotic Disease Guidance

If a disease is zoonotic (transmissible from animals to humans), this must be
clearly stated — but framed to inform, not to alarm.

**Where to mention it:**
- Briefly in `description`
- In detail in `toxicityInfo` under **Zoonotic Risk** (placed last)
- In `preventionTips` with practical safe-handling guidance

**Approved zoonotic language:**

| Context | Approved Phrasing |
|---------|-------------------|
| General statement | "This disease is zoonotic — it can be transmitted from animals to humans." |
| Handling guidance | "If your pet is suspected or confirmed to have [disease], take precautions when handling them and contact your own physician if you have concerns about your exposure." |
| High-risk populations | "Individuals who are immunocompromised, pregnant, elderly, or very young may be at greater risk and should take extra precautions." |
| Prevention tip | "Wash hands thoroughly after handling an infected animal or any materials they have contacted." |

**Tone:** State the fact clearly. Direct to physician for personal health concerns.
Do not describe severity of disease in humans. Do not use alarming language.

---

## Approved Language: Monoclonal Antibody Treatments

> "A monoclonal antibody treatment has become available in recent years that
> directly targets [pathogen/disease]. This option is most effective when
> administered early in the disease course — another reason why prompt veterinary
> evaluation is essential."

Do not name the specific product, manufacturer, or dosing.

---

## Swift Implementation Notes

```swift
// Always read ClaudeWeb_DiseaseEntryFormat.md before generating any instruction file

// Target file — NOT DatabaseService.swift
// PetToxic/Services/DiseasesConditionsService.swift

// Category
categories: [.diseasesAndConditions]

// Entry severity — ALWAYS nil
entrySeverity: nil,

// toxicityInfoSectionTitle — ALWAYS include
toxicityInfoSectionTitle: "What makes it harmful?",

// relatedEntries — plain string UUIDs, not UUID objects
relatedEntries: ["uuid-string-here", "another-uuid-string"],

// speciesRisks — include only susceptible species (unlike toxin entries)
speciesRisks: [
    SpeciesRisk(species: .reptile, severity: .severe, notes: "..."),
    // omit species not susceptible
],

// Sort order — infectious diseases listed first, then conditions
// For Type 2 or Type 3 entries, add the UUID to nonInfectiousEntryIDs:
private static let nonInfectiousEntryIDs: Set<String> = [
    "1D000001-0000-0000-0000-000000000005",  // Metabolic Bone Disease (MBD)
    // ADD NEW NON-INFECTIOUS ENTRY UUIDs HERE
]
```

---

## Entry Checklist

Before submitting any Diseases & Conditions entry for implementation:

- [ ] Entry type identified (Type 1 / Type 2 / Type 3) — guides section structure and sort order
- [ ] If Type 2 or Type 3: UUID added to `nonInfectiousEntryIDs` in `DiseasesConditionsService`
- [ ] `name` includes species qualifier or common name if needed
- [ ] `alternateNames` includes abbreviations, lay terms, misspellings
- [ ] `description` covers: what it is, acute/chronic, life-threatening potential,
      infectious status, vaccine status if relevant, most at-risk populations
- [ ] `toxicityInfo` section structure matches entry type:
  - Type 1: How It Harms the Body → Transmission & Spread → Treatment Goals → (Zoonotic Risk)
  - Type 2: How It Harms the Body → Causes & Risk Factors → Treatment Goals
  - Type 3: How It Harms the Body → Causes & Risk Factors → Treatment Goals → (Zoonotic Risk)
- [ ] `toxicityInfoSectionTitle` set to `"What makes it harmful?"`
- [ ] `onsetTime` reflects the real clinical course — not forced into incubation mold
- [ ] `symptoms` are observable by owners; listed early-to-severe; no lab findings
- [ ] `entrySeverity` set to `nil`
- [ ] `speciesRisks` includes only genuinely susceptible species; omitted species
      noted briefly in `description` or species notes
- [ ] No mortality percentages or standalone prognosis statements
- [ ] No specific drug names, doses, or treatment protocols
- [ ] `preventionTips` depth matches how preventable the condition actually is;
      no implied owner blame for idiopathic/genetic conditions
- [ ] Prevention content is in `preventionTips` — not duplicated in `toxicityInfo`
- [ ] Minimum 3 publicly accessible sources; no VIN monograph sources
- [ ] If zoonotic: stated in `description` and `toxicityInfo`; safe-handling in
      `preventionTips`; physician referral included; tone informative not alarming
- [ ] `relatedEntries` cross-references are bidirectional
- [ ] Tone matches clinical course of the specific condition

---

*End of Template Document*
*Keep in PetToxic project root folder for reference by Claude Web and Claude Code sessions.*
