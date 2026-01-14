# Pet Toxic - iOS App

## Overview
Native iOS reference app for pet owners to quickly look up toxicity information. Works offline. Never provides medical advice.

## Technical Stack
- **Language:** Swift 5.9+
- **UI:** SwiftUI
- **iOS Target:** 16.0+
- **Architecture:** MVVM
- **Database:** SQLite with FTS5 for search
- **Dependencies:** Minimize; prefer native frameworks

## Core Principles

### 1. OFFLINE FIRST
All data bundled with app. Users may be in emergencies without connectivity.

### 2. NO MEDICAL ADVICE
Never provide: dosage calculations, inducing vomiting instructions, home treatments, prognosis, medication recommendations.

### 3. ALWAYS DISCLAIM
Every article view must display the legal disclaimer prominently, visible without scrolling.

### 4. SPEED
Information accessible within 2-3 taps. Users may be panicked.

### 5. ACCESSIBILITY
Dynamic Type, VoiceOver, high contrast, 44pt minimum touch targets.

## Key Constraints

**Do NOT include:**
- Dosage or "safe amount" calculations
- Treatment instructions of any kind
- User accounts or cloud sync
- Advertisements or analytics tracking
- In-app purchases (v1.0)

## Branch Strategy
- `main` — Stable, release-ready only
- `develop` — Active development
- `feature/[name]` — Individual features
- `content/[name]` — Content additions

## Commit Format
- `feat:` New features
- `fix:` Bug fixes
- `content:` Toxicity data additions
- `docs:` Documentation updates

## Plan Mode
- Keep plans concise. Sacrifice grammar for brevity.
- End each plan with unresolved questions, if any.

## Reference Documents
- **Data Models:** Documentation/DataModels.md
- **UI Spec:** Documentation/Design/UI-Spec.md
- **Style Guide:** Documentation/Design/StyleGuide.md

## Questions Before Coding
1. Does this feature work offline?
2. Could this be construed as medical advice?
3. Is the disclaimer visible?
4. Does it meet accessibility requirements?
5. Is the code testable?
6. Correct branch?
