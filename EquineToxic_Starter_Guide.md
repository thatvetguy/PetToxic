# EquineToxic — Starter Guide

A guide for building an equine-focused toxicity reference app based on the Pet Toxic architecture.

---

## What Can Be Reused from Pet Toxic

The Pet Toxic codebase provides a production-ready foundation. Most of the architecture, UI, and infrastructure can be carried over directly.

### Reuse Directly (Minimal or No Changes)

| Component | Files | Notes |
|-----------|-------|-------|
| **App architecture** | MVVM pattern, all ViewModels | Same search → browse → article flow |
| **Navigation system** | `MainTabView`, `BrowseView`, `NavigationPath` handling | Tab bar, browse-by-category, swipe gestures — all transferable |
| **Entry data model** | `ToxicItem`, `SpeciesRisk`, `OnsetTime` | Same struct, just change species enum values |
| **Severity system** | `Severity` enum with colors, sort order, descriptions | Identical 5-level system applies to equine toxicology |
| **Entry format** | Field order, content guidelines, source rules | Same 14-field structure, same prohibited content rules |
| **Article detail view** | `ArticleDetailView`, `SeveritySection`, `SymptomsListView` | Same layout: disclaimer → image → description → symptoms → species risks → sources |
| **Disclaimer system** | `DisclaimerView` | Same legal structure; update wording from "pet" to "horse/equine" |
| **Emergency contacts** | `PoisonControlButton`, `EmergencyContact` | Same UI pattern; add equine-specific numbers |
| **Search** | `SearchService` (FTS5), `SearchViewModel` | Same full-text search with synonyms and fuzzy matching |
| **Bookmarks & history** | `BookmarkService`, `SavedViewModel` | Identical functionality |
| **Appearance settings** | `AppearanceSettings` (dark/light mode) | Identical |
| **IAP system** | `StoreKitService`, `ProSettings` | Same StoreKit 2 setup with Pro/Supporter tiers; change product IDs |
| **Glossary system** | `GlossaryService`, `GlossaryTerm`, `GlossaryStyledText` | Same auto-highlighting architecture; replace terms with equine vocabulary |
| **Lab Work Guide** | `LabWorkGuideService`, `LabParameter`, `LabWorkGuideView` | Same panel-based architecture; replace with equine reference ranges |
| **Share card** | `ShareCardView`, image rendering | Same share-to-social pattern |
| **Accessibility** | Dynamic Type, VoiceOver, 44pt touch targets | All built into the existing UI components |
| **Offline design** | All data bundled in-app | Same principle — equine owners may be at barns without connectivity |

### What Needs to Change

| Component | Change Required |
|-----------|----------------|
| **Species enum** | Replace 5 small-animal species with equine species (see below) |
| **Categories** | Adjust to equine-relevant categories (see below) |
| **All entries** | 100% new equine-specific content |
| **Glossary terms** | Add equine-specific medical terms (colic, laminitis, founder, etc.) |
| **Lab parameters** | Equine-specific reference ranges and panels |
| **Branding** | App icon (horseshoe replacing paw print), color scheme, App Store copy |
| **Bundle ID** | New bundle identifier (e.g., `com.equinetoxic.*`) |
| **IAP product IDs** | New StoreKit product IDs |
| **Emergency contacts** | Add equine-specific poison resources |
| **Disclaimer wording** | "pet" → "horse" / "equine animal" throughout |
| **SF Symbol icons** | Species icons change; category icons may change |

---

## Species Design

### Option A: Single Species (Simpler)

If the app targets only horses, use a single species with breed/size notes:

```swift
enum Species: String, Codable, CaseIterable {
    case horse
}
```

Per-entry notes would cover size differences: "Miniature horses and foals are more susceptible due to lower body mass."

**Pros:** Simpler data model, less research per entry, faster to launch.
**Cons:** Loses the per-species severity grid that makes Pet Toxic's UI informative.

### Option B: Multiple Equine Species (Recommended)

Mirrors Pet Toxic's multi-species approach for richer content:

```swift
enum Species: String, Codable, CaseIterable, Identifiable, Comparable {
    case horse         // Adult horses (all breeds)
    case pony          // Ponies (Welsh, Shetland, etc.) — more sensitive to some toxins
    case miniature     // Miniature horses — highest sensitivity per body weight
    case donkeyMule    // Donkeys and mules — different metabolism for some substances
    case foal          // Foals — immature systems, higher vulnerability

    var displayName: String {
        switch self {
        case .horse: return "Horses"
        case .pony: return "Ponies"
        case .miniature: return "Miniature Horses"
        case .donkeyMule: return "Donkeys & Mules"
        case .foal: return "Foals"
        }
    }

    var icon: String {
        switch self {
        // Note: verify SF Symbol availability for iOS 17+
        case .horse: return "figure.equestrian.sports"
        case .pony: return "figure.equestrian.sports"
        case .miniature: return "figure.equestrian.sports"
        case .donkeyMule: return "figure.equestrian.sports"
        case .foal: return "figure.equestrian.sports"
        }
    }
}
```

**Why this split matters clinically:**
- **Ponies** are more susceptible to hyperlipemia/hepatic lipidosis and pasture-associated laminitis
- **Miniature horses** have higher toxin-to-bodyweight ratios and are more prone to hyperlipemia
- **Donkeys** metabolize some drugs differently (e.g., phenylbutazone has shorter half-life)
- **Foals** have immature hepatic/renal function and different toxin sensitivities

**Recommendation:** Option B — it directly mirrors Pet Toxic's architecture and the species grid is one of the app's most useful features.

---

## Suggested Equine Categories

| Category | Key | Suggested Icon | Description |
|----------|-----|----------------|-------------|
| Pasture & Forage | `.pastureForage` | `leaf.fill` | Toxic plants, pasture hazards, hay contamination |
| Feed & Supplements | `.feedSupplements` | `fork.knife` | Contaminated feed, ionophores, supplement toxicity |
| Medications | `.medications` | `pills.fill` | NSAID toxicity, sedation risks, drug interactions |
| Barn & Stable | `.barnStable` | `house.fill` | Chemicals stored in barns, bedding hazards |
| Pesticides & Herbicides | `.pesticidesHerbicides` | `spray.fill` or `wrench.and.screwdriver.fill` | Organophosphates, herbicide drift, fly spray toxicity |
| Environmental | `.environmental` | `figure.hiking` | Snake bites, insect stings, blister beetles, water quality |
| Garden & Landscape | `.gardenLandscape` | `tree.fill` | Ornamental plants, garden chemicals, mulch |
| Informational | `.informational` | `info.circle.fill` | Umbrella entries, educational content, mechanical hazards |

**Notes:**
- "Pasture & Forage" replaces "Plants" — more specific to equine context
- "Feed & Supplements" replaces "Foods" — horses don't eat human food, but contaminated feed is a major concern
- "Barn & Stable" replaces "Household Items" — equine-specific environment
- Holiday Hazards and Recreational Substances likely not needed for equine

---

## Suggested Initial Entry List

Organized by category. This is a starting list — the app developer (a veterinarian) will validate all content.

### Pasture & Forage — Toxic Plants (~25-30 entries)

| Entry | Severity | Notes |
|-------|----------|-------|
| Red Maple | Severe | Oxidative damage to RBCs; dried/wilted leaves most dangerous |
| Black Walnut | Severe | Shavings cause laminitis; contact exposure sufficient |
| Yew (Taxus) | Severe | Cardiac glycosides; sudden death possible |
| Oleander | Severe | Cardiac glycosides; all parts toxic; very small amounts lethal |
| Sorghum / Sudan Grass | High | Cystitis syndrome, hindlimb ataxia |
| Tall Fescue (Endophyte-Infected) | High | Ergot alkaloids; reproductive losses, agalactia, prolonged gestation |
| Alsike Clover | High | Photosensitization, liver disease ("big liver disease") |
| White Snakeroot | Severe | Tremetol; "trembles" disease |
| Yellow Star Thistle / Russian Knapweed | Severe | Nigropallidal encephalomalacia ("chewing disease"); irreversible |
| Bracken Fern | High | Thiaminase; thiamine deficiency |
| Horsetail (Equisetum) | High | Thiaminase; similar mechanism to bracken fern |
| Hemlock (Poison & Water) | Severe | Alkaloids; respiratory paralysis |
| Nightshade (various) | High | Solanine alkaloids; GI and neurological signs |
| Privet | Moderate | GI irritation, possible cardiac effects |
| Tansy Ragwort / Groundsel | Severe | Pyrrolizidine alkaloids; cumulative liver damage |
| Locoweed (Astragalus/Oxytropis) | Severe | Swainsonine; neurological; irreversible with chronic exposure |
| Wild Cherry / Chokecherry | Severe | Cyanogenic glycosides; wilted leaves most dangerous |
| Buttercup | Low-Moderate | Protoanemonin; oral irritation, blistering |
| Acorns (Oak) | High | Tannins; renal damage with large/repeated ingestion |
| Rhododendron / Azalea | High | Grayanotoxins; cardiac and GI effects |
| Jimsonweed (Datura) | High | Tropane alkaloids; anticholinergic syndrome |
| Kleingrass | High | Hepatogenous photosensitization |
| Perilla Mint | Severe | Perilla ketone; acute respiratory distress (ARDS) |
| Pokeweed | High | Saponins and oxalates; GI irritation |
| Milkweed | High | Cardiac glycosides |

### Feed & Supplements (~8-10 entries)

| Entry | Severity | Notes |
|-------|----------|-------|
| Ionophores (Monensin/Lasalocid) | Severe | Cross-contamination from cattle feed; cardiac muscle damage; often fatal |
| Botulism (Contaminated Feed) | Severe | Clostridium botulinum in haylage/silage/round bales |
| Fumonisin (Moldy Corn) | Severe | Equine leukoencephalomalacia (ELEM); "moldy corn disease" |
| Blister Beetles (Cantharidin) | Severe | Found in alfalfa hay; GI and urinary tract damage |
| Excess Selenium | High | Selenium toxicosis from over-supplementation or seleniferous soils |
| Excess Iron | High | Iron overload; hepatic damage |
| Nitrate/Nitrite Poisoning | Severe | Contaminated hay or water; methemoglobinemia |
| Aflatoxin (Moldy Feed) | High | Hepatotoxic mycotoxin |

### Medications (~10-12 entries)

| Entry | Severity | Notes |
|-------|----------|-------|
| Phenylbutazone (Bute) Toxicity | High | Right dorsal colitis, renal papillary necrosis |
| Flunixin (Banamine) Toxicity | High | Renal damage, GI ulceration at high/prolonged doses |
| Ivermectin Overdose | High | Neurological signs; especially in foals and debilitated horses |
| Aminoglycoside Toxicity | High | Nephrotoxicity, ototoxicity |
| Organophosphate/Carbamate Insecticides | Severe | Cholinergic crisis; some dewormers and fly sprays |
| Metaldehyde (Slug Bait) | Severe | Seizures; horses may access in barns/gardens |
| Fluoroquinolone (Enrofloxacin) | High | Articular cartilage damage in horses |
| Procaine Penicillin Reaction | Moderate | Acute CNS excitation from inadvertent IV administration |
| Detomidine / Xylazine (Sedation Risks) | Informational | Educational on alpha-2 agonist risks, not toxicosis |

### Barn & Stable (~5-6 entries)

| Entry | Severity | Notes |
|-------|----------|-------|
| Lead Paint / Lead | Severe | Old barn paint; neurological signs ("lead colic") |
| Ethylene Glycol (Antifreeze) | Severe | Sweet taste; renal failure |
| Rodenticides | Informational | Umbrella entry (anticoagulant, bromethalin, cholecalciferol) |
| Pine Oil / Phenol Disinfectants | Moderate | Skin/respiratory irritation from stable cleaning products |
| Carbon Monoxide | Severe | Barn fires, poorly ventilated heating |

### Pesticides & Herbicides (~4-5 entries)

| Entry | Severity | Notes |
|-------|----------|-------|
| Organophosphates & Carbamates | Severe | Fly sprays, dewormers; cholinesterase inhibition |
| Herbicide Drift (2,4-D, Glyphosate) | Moderate | Pasture contamination from neighboring properties |
| Arsenic (Old Dipping Vats/CCA Wood) | Severe | Historical exposure; GI and multi-organ damage |
| Pyrethrin/Pyrethroid Toxicity | Low-Moderate | Usually well tolerated in horses but possible sensitivity |

### Environmental (~6-8 entries)

| Entry | Severity | Notes |
|-------|----------|-------|
| Rattlesnake / Pit Viper Envenomation | High | Facial swelling can obstruct airways |
| Coral Snake Envenomation | Severe | Neurotoxic; less common in horses |
| Black Widow Spider | Moderate | Muscle fasciculations, colic signs |
| Blister Beetles (Field Exposure) | Severe | Cross-list with Feed; direct skin contact |
| Blue-Green Algae (Cyanobacteria) | Severe | Contaminated water sources; hepatotoxic and neurotoxic |
| Fire Ant Stings | Low-Moderate | Urticarial reactions; danger if horse lies in mound |
| Lightning Strike | Informational | Educational; barn grounding, pasture safety |

### Informational / Umbrella (~4-5 entries)

| Entry | Notes |
|-------|-------|
| Colic & Toxic Causes | Umbrella: many toxins present as colic |
| Laminitis & Toxic Causes | Umbrella: black walnut, carbohydrate overload, endophyte fescue |
| Photosensitization | Umbrella: alsike clover, kleingrass, St. John's wort |
| Pyrrolizidine Alkaloid Plants | Umbrella: ragwort, groundsel, Crotalaria, Heliotrope |

**Estimated total: ~65-75 entries for initial launch**

---

## Emergency Contacts for Equine App

| Contact | Phone | Notes |
|---------|-------|-------|
| ASPCA Animal Poison Control | (888) 426-4435 | Handles equine cases; consultation fee may apply |
| Pet Poison Helpline | (855) 764-7661 | Handles equine cases; consultation fee may apply |

These are the same two primary resources — both handle equine calls. The app could also include a prompt to "Call your equine veterinarian" as the primary action, since equine emergencies typically require an on-site vet visit (unlike small animals that are transported to a clinic).

---

## Equine-Specific Glossary Terms

Terms to add beyond the existing Pet Toxic glossary:

| Term | Category | Definition Focus |
|------|----------|-----------------|
| Colic | Conditions | Abdominal pain; many causes; toxin-induced vs. surgical |
| Laminitis | Conditions | Inflammation of the laminae; connection to toxins |
| Founder | Conditions | Chronic/structural laminitis; mechanical displacement of coffin bone |
| Choke | Conditions | Esophageal obstruction (not respiratory) |
| Tying Up / Rhabdomyolysis | Conditions | Muscle breakdown; exertional vs. toxin-induced |
| Equine Metabolic Syndrome | Conditions | Insulin dysregulation; relevance to laminitis triggers |
| Hepatic Encephalopathy | Conditions | Neurological signs from liver failure (ragwort, etc.) |
| Leukoencephalomalacia (ELEM) | Conditions | Brain lesions from fumonisin (moldy corn) |
| Cyanide / HCN | Mechanisms | Cyanogenic glycosides (cherry, sorghum); cellular asphyxiation |
| Pyrrolizidine Alkaloids | Mechanisms | Cumulative liver toxins (ragwort, groundsel) |
| Cardiac Glycosides | Mechanisms | Heart-affecting toxins (oleander, yew, foxglove) |
| Cholinesterase Inhibition | Mechanisms | Organophosphate/carbamate mechanism |
| Ionophore | Mechanisms | Feed additive toxic to horses; cardiac myocyte damage |
| Tremetol | Mechanisms | White snakeroot toxin; "trembles" |
| Grayanotoxin | Mechanisms | Rhododendron/azalea toxin |
| Hyperlipemia | Conditions | Fat mobilization crisis; ponies and miniatures especially |
| Dorsal Colitis | Conditions | Right dorsal colon inflammation from NSAID toxicity |
| Photosensitization | Conditions | Skin damage from sunlight + photodynamic agents |
| Ergot Alkaloids | Mechanisms | Fescue toxicosis mechanism |

---

## Lab Work Guide — Equine Adaptation

The existing `LabWorkGuideService` architecture (panel types, categories, parameter detail view) transfers directly. Changes needed:

**Replace reference ranges** — equine normals differ significantly from small animal:
- PCV (packed cell volume): Horse ~32-52% vs. Dog ~37-55%
- Total protein: Horse ~5.7-8.0 g/dL
- Fibrinogen: Routinely measured in horses (acute phase protein); 100-400 mg/dL normal
- SAA (Serum Amyloid A): Key equine acute phase protein; not commonly measured in small animals
- GGT: More clinically significant in horses for liver/biliary disease
- CK / AST: Key for rhabdomyolysis / tying-up diagnosis
- Lactate: Critical for colic triage and prognosis

**Add equine-specific parameters:**
- Serum Amyloid A (SAA)
- Fibrinogen (by heat precipitation)
- Lactate (venous and peritoneal)
- ACTH (for PPID/Cushing's diagnosis)
- Insulin (for metabolic syndrome)
- Peritoneal fluid analysis (specific to equine colic workup)

**Panel types may need adjustment:**
- Add "Peritoneal Fluid" panel type
- Add "Endocrine" panel type (ACTH, insulin, cortisol, thyroid)
- Keep CBC, Chemistry, Coagulation, Urinalysis

---

## Branding Changes

| Element | Pet Toxic | EquineToxic |
|---------|-----------|-------------|
| App icon | Paw print in warning triangle | Horseshoe in warning triangle |
| Accent color | Teal/dark theme | Consider barn red, saddle brown, or forest green |
| Species icons | `dog`, `cat`, `hare`, `bird`, `lizard` | `figure.equestrian.sports` or custom |
| App Store subtitle | "Pet Poison Guide" | "Equine Poison Guide" |
| Category icons | Small-animal focused | Equine-environment focused |

---

## Recommended Equine Toxicology Sources

**Primary references (highest priority):**
1. ASPCA Animal Poison Control Center (equine cases)
2. Pet Poison Helpline (equine division)
3. Merck Veterinary Manual — Toxicology section (equine-specific chapters)
4. "Large Animal Internal Medicine" (Smith, 6th ed.)
5. "Veterinary Toxicology" (Gupta, 3rd ed.)

**Academic / peer-reviewed:**
6. JAVMA (Journal of the American Veterinary Medical Association)
7. Equine Veterinary Journal (EVJ)
8. Equine Veterinary Education (EVE)
9. Journal of Veterinary Internal Medicine (JVIM)
10. Journal of Veterinary Emergency and Critical Care (JVECC)

**University resources:**
11. UC Davis Center for Equine Health
12. Cornell University Poisonous Plants Database
13. Purdue University Veterinary Toxicology
14. University of Minnesota Equine Extension

**Practice resources:**
15. AAEP (American Association of Equine Practitioners) — member resources
16. VCA Animal Hospitals / VCA Equine
17. Veterinary Partner (public VIN resource)

**Plant identification:**
18. USDA PLANTS Database (plant identification and distribution)
19. University extension services (state-specific toxic plant guides)

---

## Implementation Sequence

Suggested order for building EquineToxic:

1. **Fork Pet Toxic codebase** — start with the full working app
2. **Update Species enum** — replace 5 small-animal species with equine species
3. **Update Category enum** — adjust categories for equine context
4. **Update branding** — app icon, accent colors, display names
5. **Update disclaimer and emergency contacts** — equine-specific wording
6. **Build initial entries** (~20-25 highest-priority toxicoses) — enough for a functional MVP
7. **Update glossary** — add equine-specific terms, remove irrelevant small-animal terms
8. **Update Lab Work Guide** — equine reference ranges and parameters
9. **Update IAP product IDs** — new bundle for App Store
10. **Expand entries** to full ~65-75 count
11. **Generate thumbnail images** — same AI-generation workflow, equine subjects
12. **App Store submission** — new listing, equine-focused screenshots and copy

---

## Architecture Diagram (What Stays, What Changes)

```
┌─────────────────────────────────────────────────────┐
│                    EquineToxic App                   │
├─────────────────────────────────────────────────────┤
│                                                     │
│  KEEP AS-IS              MODIFY                     │
│  ─────────              ──────                      │
│  MainTabView            Species enum (5 equine)     │
│  BrowseView             Category enum (8 equine)    │
│  ArticleDetailView      DatabaseService (all new    │
│  SearchService            entries)                  │
│  BookmarkService        GlossaryService (equine     │
│  StoreKitService          terms)                    │
│  ProSettings            LabWorkGuideService (equine │
│  AppearanceSettings       reference ranges)         │
│  NavigationPath logic   DisclaimerView (wording)    │
│  ShareCardView          PoisonControlButton (add    │
│  GlossaryStyledText       equine resources)         │
│  All ViewModels         Assets (new thumbnails,     │
│  All UI Components        app icon)                 │
│  Accessibility          Bundle ID & IAP IDs         │
│  Offline architecture   App Store metadata          │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

*Generated from Pet Toxic codebase — February 2026*
