# Pet Toxic - Design Document & Development Roadmap

**Pet Toxicity Reference App**

Version 1.0 | January 2026

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Product Overview](#2-product-overview)
3. [Target Audience](#3-target-audience)
4. [Features & Requirements](#4-features--requirements)
5. [Technical Architecture](#5-technical-architecture)
6. [Data Model](#6-data-model)
7. [User Interface Design](#7-user-interface-design)
8. [Content Strategy](#8-content-strategy)
9. [Legal & Compliance](#9-legal--compliance)
10. [Development Roadmap](#10-development-roadmap)
11. [Appendices](#11-appendices)

---

## 1. Executive Summary

Pet Toxic is a native iOS application designed to serve as a quick-reference guide for pet owners to determine if a substance is toxic to their pets. The app provides offline-accessible information about common household items, foods, plants, medications, and other substances that may pose a risk to dogs, cats, and exotic pets.

The app is designed with a clear medical disclaimer that it does not provide veterinary medical advice, and consistently directs users to seek professional veterinary care. It includes quick-access links to poison control hotlines (ASPCA Poison Control, Pet Poison Helpline) for emergency situations.

### Key Value Propositions

- Instant offline access to toxicity information during emergencies
- Veterinarian-reviewed content ensuring accuracy
- Simple, stress-friendly interface for panicked pet owners
- Multi-species support (dogs, cats, exotic pets)
- One-time purchase with no ads for distraction-free use

---

## 2. Product Overview

### 2.1 App Identity

| Attribute | Value |
|-----------|-------|
| App Name | Pet Toxic |
| Platform | iOS (iPhone) - Native Swift/SwiftUI |
| Price | $1.99 - $2.99 (one-time purchase, no ads) |
| Target iOS Version | iOS 16.0+ (to maximize compatibility) |
| Offline Support | Yes - Full database available offline |
| User Accounts | None required - Anonymous use |

### 2.2 Design Philosophy

The app prioritizes clarity and speed over visual complexity. Users accessing this app may be in stressful situations where their pet has potentially ingested something harmful. The interface must be calming yet professional, with clear information hierarchy and minimal cognitive load.

**Design Principles:**

- **Speed First:** Information must be accessible within 2-3 taps from launch
- **Clarity Over Cleverness:** No ambiguous icons or hidden menus
- **Calm Professionalism:** Clinical enough to be trustworthy, warm enough to be approachable
- **Consistent Disclaimers:** Every article reminds users to seek professional advice
- **Emergency Access:** Poison control contacts always one tap away

---

## 3. Target Audience

### 3.1 Primary Users

- Pet owners (dogs, cats, exotic pets) seeking quick toxicity information
- Pet sitters, dog walkers, and boarding facility staff
- Veterinary clinic front desk staff (for quick client guidance)
- Prospective pet owners researching home safety

### 3.2 Use Case Scenarios

**Emergency Scenario**

A dog owner discovers their Labrador has chewed through a bag of raisins. They need to immediately know: Is this dangerous? How dangerous? What should I do? The app provides the severity level and directs them to call poison control.

**Preventive Scenario**

A new cat owner is buying houseplants and wants to verify which plants are safe before bringing them home. They browse the Plants category filtered by "Cats" to make informed decisions.

**Curiosity Scenario**

A pet owner sees a social media post claiming garlic is toxic to dogs and wants to verify the claim and understand the actual risk level.

---

## 4. Features & Requirements

### 4.1 Core Features (MVP)

#### Search Functionality

- Full-text search across all toxicity entries
- Fuzzy matching for misspellings (e.g., "ibuprofin" matches "ibuprofen")
- Synonym support (e.g., "Tylenol" matches "acetaminophen")
- Brand name and generic name matching
- Case-insensitive search
- Results ranked by relevance with best match first

#### Species Filter

- Filter by: Dogs, Cats, Small Mammals (rabbits, guinea pigs, hamsters), Birds, Reptiles
- Optional filter - users can search without selecting a species
- Species-specific toxicity levels where applicable

#### Category Browsing

Users can browse by category instead of searching:

- Foods (human foods, pet food ingredients)
- Plants (houseplants, outdoor plants, flowers)
- Human Medications (OTC, prescription)
- Cleaning Products
- Garage & Garden (antifreeze, fertilizers, pesticides, mulch)
- Recreational Substances (cannabis, alcohol, nicotine)
- Holiday Hazards (seasonal items cross-referenced)
- Environmental Hazards
- Household Items (includes essential oils)
- Other Hazards
- Animal Encounters

#### Toxicity Articles

Each entry displays:

- Item name and image/illustration
- Toxicity severity indicator (color-coded: Low/Moderate/High/Severe)
- Species-specific risk levels
- Brief description of toxicity mechanism
- Common symptoms to watch for
- Disclaimer and professional advice reminder
- Quick-access poison control buttons

#### Emergency Contacts

- ASPCA Animal Poison Control: (888) 426-4435
- Pet Poison Helpline: (855) 764-7661
- One-tap calling functionality
- Note about consultation fees

#### User Features

- Bookmarks/Favorites: Save frequently referenced items
- Search History: View recent searches for quick re-access

### 4.2 Future Features (Post-Launch)

- GPS-based emergency vet locator
- "My Pets" profiles for personalized filtering
- Fish and horse toxicity data
- Android version
- Push notifications for seasonal hazard alerts

### 4.3 Explicit Non-Features

The following will NOT be included to avoid liability issues:

- Dosage calculations or "safe amount" information
- Instructions for inducing vomiting
- Home treatment recommendations
- Prognosis or outcome predictions
- Any content that could be construed as veterinary medical advice

---

## 5. Technical Architecture

### 5.1 Technology Stack

| Component | Technology |
|-----------|------------|
| Language | Swift 5.9+ |
| UI Framework | SwiftUI (primary) with UIKit integration as needed |
| Local Database | SwiftData (iOS 17+) or Core Data (iOS 16 compatibility) |
| Search Engine | SQLite FTS5 (Full-Text Search) for fuzzy matching |
| Architecture | MVVM (Model-View-ViewModel) |
| Minimum iOS | iOS 16.0 |

### 5.2 Data Storage Strategy

**Bundled Database**

The toxicity database will be bundled with the app as a pre-populated SQLite database. This ensures complete offline functionality from first launch.

**User Data (Local Only)**

- Bookmarks stored in UserDefaults or local database
- Search history stored locally (last 50 searches)
- No cloud sync - all data stays on device

**Database Updates**

New toxicity data will be delivered through app updates via the App Store. This approach is simpler than a remote sync system and ensures all users have verified, reviewed content.

### 5.3 Search Implementation

The search system will use SQLite FTS5 (Full-Text Search) with the following features:

- Prefix matching: "acet" matches "acetaminophen"
- Edit distance matching for typos (Levenshtein distance)
- Synonym table for common name mappings
- Relevance ranking based on match quality

---

## 6. Data Model

### 6.1 Core Entities

#### ToxicItem

The primary entity representing a toxic substance:

| Field | Type | Description |
|-------|------|-------------|
| id | UUID | Unique identifier |
| name | String | Primary display name |
| alternateNames | [String] | Brand names, synonyms, common misspellings |
| categories | [Category] | Foods, Plants, Medications, etc. |
| imageAsset | String? | Asset catalog image name |
| description | String | Brief explanation of what it is |
| toxicityInfo | String | How/why it causes harm |
| symptoms | [String] | Common symptoms to watch for |
| speciesRisks | [SpeciesRisk] | Per-species toxicity levels |
| sources | [String] | Reference sources for content |

#### SpeciesRisk

Toxicity level for a specific species:

| Field | Type | Description |
|-------|------|-------------|
| species | Species | Dog, Cat, SmallMammal, Bird, Reptile |
| severity | Severity | Low, Moderate, High, Severe |
| notes | String? | Species-specific notes |

### 6.2 Enumerations

#### Severity Levels

| Level | Color | Meaning |
|-------|-------|---------|
| Low | Green | Mild GI upset possible; monitor at home |
| Moderate | Yellow | Vet consultation recommended |
| High | Orange | Seek veterinary care promptly |
| Severe | Red | Potentially life-threatening; emergency care needed |

#### Categories

Foods, Plants, HumanMedications, CleaningProducts, EssentialOils, GarageAutomotive, GardenProducts, RecreationalSubstances, HolidayHazards

#### Species

Dog, Cat, SmallMammal, Bird, Reptile (Fish and Horse reserved for future)

---

## 7. User Interface Design

### 7.1 Navigation Structure

The app uses a tab-based navigation with four main sections:

- **Search (Home)** - Primary search interface with species filter
- **Browse** - Category-based browsing
- **Saved** - Bookmarks and search history
- **Emergency** - Quick access to poison control contacts

### 7.2 Screen Descriptions

#### Search Screen (Home Tab)

- Large, prominent search bar at top
- Species filter chips below search bar (All, Dogs, Cats, Small Pets, Birds, Reptiles)
- Quick category buttons for common searches
- Recent searches displayed when search is empty
- Results appear as scrollable list with severity indicator

#### Browse Screen

- Grid of category cards with icons
- Tapping category shows filtered list of items
- Species filter available within category view

#### Article Detail Screen

- Item image/illustration at top
- Item name and severity badge
- Species-specific severity indicators (if multiple species)
- "What is it?" section
- "Why is it toxic?" section
- "Symptoms to watch for" section
- Prominent disclaimer box
- "Call Poison Control" buttons
- Bookmark button in navigation bar

#### Saved Screen

- Segmented control: Bookmarks | History
- Bookmarks: List of saved items with swipe-to-delete
- History: Recent searches with timestamps
- Clear history option

#### Emergency Screen

- Large, tap-to-call buttons for each hotline
- Brief description of each service
- Note about consultation fees
- Tips for what information to have ready when calling

### 7.3 Visual Design Guidelines

#### Color Palette

- **Primary:** Calming teal/blue-green (#4A9B9B or similar)
- **Background:** Soft white/light gray (#F8F9FA)
- **Severity colors:** Green (low), Yellow (moderate), Orange (high), Red (severe)
- **Text:** Dark gray (#333333) for readability

#### Typography

- System fonts (SF Pro) for native iOS feel
- Clear hierarchy: Headlines, body, captions
- Minimum 16pt for body text (accessibility)

#### Iconography

- SF Symbols for system consistency
- Custom icons for categories (AI-generated or MeshyAI)
- Consistent style: rounded, friendly but professional

---

## 8. Content Strategy

### 8.1 Content Creation Workflow

1. **AI Draft Generation:** Claude generates initial article drafts with cited sources
2. **Veterinary Review:** You review and edit for accuracy
3. **Source Verification:** Confirm against ASPCA, VIN, Merck Vet Manual
4. **Database Entry:** Add to SQLite database in JSON format
5. **Image Creation:** Generate illustrations via MeshyAI or similar

### 8.2 Article Template

Each toxicity article will follow this structure:

- **Item Name:** Primary name (plus alternate names for search)
- **Severity:** Per-species toxicity level
- **Description:** 1-2 sentences about what the item is
- **Toxicity Mechanism:** Brief explanation of how it causes harm
- **Symptoms:** Bulleted list of common symptoms
- **Disclaimer:** Standard legal disclaimer

### 8.3 Launch Content Targets

**Phase 1 (MVP Launch):** 200-300 items covering the most common toxins across all categories. Priority given to items with high search volume and serious toxicity concerns.

**Phase 2 (Post-Launch):** Expand to 500+ items based on user feedback and search analytics.

### 8.4 Source References

- ASPCA Animal Poison Control
- Pet Poison Helpline
- Merck Veterinary Manual
- VIN (Veterinary Information Network)
- Veterinary Partner (veterinarypartner.com)
- Peer-reviewed veterinary toxicology literature

---

## 9. Legal & Compliance

### 9.1 Required Disclaimers

The following disclaimer must appear on every article page and in the app's terms of service:

> **DISCLAIMER:** This app provides general educational information only and does not constitute veterinary medical advice. The information presented should not be used as a substitute for professional veterinary care. If you believe your pet has ingested or been exposed to a toxic substance, contact a licensed veterinarian or animal poison control center immediately. Every animal is different, and treatment decisions should only be made by a licensed veterinary professional with knowledge of your specific pet.

### 9.2 What We Will NOT Provide

- Dosage calculations or "toxic dose" information
- Instructions for inducing vomiting at home
- Home treatment or first aid instructions
- Prognosis or survival rate information
- Recommendations for specific medications or treatments

### 9.3 Legal Review

Before App Store submission, the following should be reviewed by a veterinary attorney:

- App disclaimer language
- Terms of Service
- Privacy Policy
- Sample article content for liability assessment

---

## 10. Development Roadmap

### Phase 1: Foundation (Weeks 1-4)

**Week 1-2: Project Setup**
- Create Xcode project with SwiftUI
- Set up project structure (MVVM architecture)
- Design and implement data models
- Create SQLite database schema
- Implement basic tab navigation

**Week 3-4: Core Search**
- Implement FTS5 full-text search
- Build search UI with results list
- Add fuzzy matching and synonym support
- Implement species filter functionality

### Phase 2: Features (Weeks 5-8)

**Week 5-6: Article Display**
- Design and build article detail view
- Implement severity indicator UI
- Add disclaimer component
- Integrate poison control call buttons

**Week 7-8: Browse & Saved**
- Build category browsing grid
- Implement bookmarks functionality
- Add search history tracking
- Build Emergency contacts screen

### Phase 3: Content & Polish (Weeks 9-12)

**Week 9-10: Content Population**
- Generate AI drafts for 200-300 items
- Veterinary review and editing
- Create/source item images
- Populate database with verified content

**Week 11-12: Polish & Testing**
- UI/UX refinement
- App icon and branding finalization
- Accessibility testing
- Performance optimization
- Beta testing with select users

### Phase 4: Launch (Weeks 13-14)

- Legal review of disclaimers
- App Store assets (screenshots, description)
- TestFlight submission
- App Store submission
- Launch!

---

## 11. Appendices

### Appendix A: Sample Toxicity Entry (JSON)

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "name": "Chocolate",
  "alternateNames": ["cocoa", "cacao", "dark chocolate", "milk chocolate", "baking chocolate"],
  "categories": ["foods", "holidayHazards"],
  "imageAsset": "chocolate",
  "description": "Chocolate is a food product made from roasted cacao beans, commonly found in candy, baked goods, and beverages.",
  "toxicityInfo": "Chocolate contains theobromine and caffeine, both methylxanthines that dogs and cats cannot metabolize efficiently. Dark chocolate and baking chocolate contain higher concentrations and pose greater risk.",
  "symptoms": [
    "Vomiting",
    "Diarrhea",
    "Increased thirst and urination",
    "Restlessness or hyperactivity",
    "Rapid breathing",
    "Muscle tremors",
    "Seizures (in severe cases)"
  ],
  "speciesRisks": [
    {
      "species": "dog",
      "severity": "high",
      "notes": "Dogs are particularly sensitive to theobromine"
    },
    {
      "species": "cat",
      "severity": "high",
      "notes": "Cats rarely consume chocolate but are equally sensitive"
    }
  ],
  "sources": [
    "ASPCA Animal Poison Control Center",
    "Merck Veterinary Manual"
  ]
}
```

### Appendix B: Category Icons

| Category | SF Symbol |
|----------|-----------|
| Foods | fork.knife |
| Plants | leaf.fill |
| Human Medications | pills.fill |
| Cleaning Products | bubbles.and.sparkles |
| Garage & Garden | wrench.and.screwdriver.fill |
| Recreational Substances | smoke.fill |
| Holiday Hazards | gift.fill |
| Environmental Hazards | exclamationmark.triangle.fill |
| Household Items | house.fill |
| Other Hazards | exclamationmark.octagon.fill |
| Animal Encounters | pawprint.fill |

### Appendix C: Priority Items for Launch

High-priority items to include in the initial database:

**Foods**
Chocolate, grapes/raisins, xylitol, onions, garlic, macadamia nuts, avocado, alcohol, caffeine, raw dough/yeast

**Plants**
Lilies, sago palm, tulips, azaleas, oleander, philodendron, pothos, dieffenbachia, aloe vera, marijuana

**Medications**
Acetaminophen (Tylenol), ibuprofen (Advil), naproxen (Aleve), aspirin, antidepressants, ADHD medications, sleep aids, blood pressure medications

**Household**
Antifreeze, rat poison, insecticides, bleach, drain cleaners, batteries, pennies (zinc), mothballs
