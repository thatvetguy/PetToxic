# PetToxic UI Patterns Reference

> Generated from live codebase — February 2026

---

## Design Philosophy

- **Offline-first** — all data bundled; users may be in emergencies without connectivity
- **Speed** — information accessible within 2-3 taps
- **No ads, no analytics, no tracking** — privacy-first design
- **Dark-first** — dark mode forced at app level; teal accent color
- **Disclaimer always visible** — legal disclaimer at top of every article, visible without scrolling
- **Never medical advice** — informational only; always directs to veterinarian

---

## Color Scheme

### Primary Colors

| Color | Hex | Usage |
|-------|-----|-------|
| Teal | `rgb(0.29, 0.61, 0.61)` | Accent color, glossary highlights, selected chips, Pro badges |
| AccentColor | Asset catalog | Primary UI accent (matches teal) |
| Background gradient | `#1A3A3A → #0D1F1F` | Linear gradient on all screens (AppBackground) |

### Severity Colors

| Level | Hex | Color |
|-------|-----|-------|
| Low | `#90EE90` | Light green |
| Low-Moderate | `#FFDE32` | Yellow |
| Moderate | `#FFD700` | Gold |
| High | `#FFA500` | Orange |
| Severe | `#FF4444` | Red |

### Disclaimer Colors

| Element | Hex |
|---------|-----|
| Background | `#FFF3CD` |
| Border | `#FFECB5` |

### Text Colors

| Element | Color |
|---------|-------|
| Primary text | White |
| Secondary text | White @ 70% opacity |
| Tertiary text | White @ 50% opacity |
| Disabled | White @ 30% opacity |
| Selected tab | AccentColor (teal) |
| Unselected tab | White @ 60% opacity |

### Surface Colors

| Element | Color |
|---------|-------|
| Card backgrounds | White @ 8-10% opacity |
| Search bar background | White @ 10% opacity |
| Dividers | White @ 10% opacity |
| Tab bar background | Black @ 90% opacity |

---

## Typography

### Fonts

| Usage | Font | Fallback |
|-------|------|----------|
| App title | Poppins Bold | SF Rounded Bold |
| Tagline | Poppins SemiBold | SF Rounded SemiBold |
| All other text | System (SF Pro) | — |

Custom Poppins fonts loaded via `Font+Poppins.swift` extension with graceful fallback.

### Text Rendering

Three markdown text components with different capabilities:

| Component | Markdown | Glossary Highlighting | Search Highlighting | Paragraph Spacing |
|-----------|----------|----------------------|--------------------|--------------------|
| `GlossaryStyledText` | Bold, italic | Teal (first occurrence, whole-word) | Yellow background | Splits on `\n\n` → VStack(spacing: 12) |
| `HighlightableMarkdownText` | Inline syntax | No | Yellow background (min 3 chars) | No |
| `MarkdownText` | `inlineOnlyPreservingWhitespace` | No | No | No |

**Search highlighting:** Semi-transparent gold (#FFD700 @ 35% opacity) background on matching text.

**Glossary highlighting:** Teal foreground color on first occurrence of each recognized glossary term. Whole-word boundary matching only.

---

## Spacing System

Defined in `Constants.swift`:

| Token | Value |
|-------|-------|
| `AppSpacing.xs` | 4pt |
| `AppSpacing.sm` | 8pt |
| `AppSpacing.md` | 16pt |
| `AppSpacing.lg` | 24pt |
| `AppSpacing.xl` | 32pt |

### Corner Radii

| Token | Value |
|-------|-------|
| `AppCornerRadius.small` | 8pt |
| `AppCornerRadius.medium` | 12pt |
| `AppCornerRadius.large` | 16pt |

### Layout Constants

| Token | Value | Usage |
|-------|-------|-------|
| `AppLayout.tabBarBottomPadding` | 80pt | Prevents content from hiding behind tab bar |

---

## Navigation Patterns

### Tab Bar

Custom HStack tab bar (not SwiftUI TabView):
- 5 tabs: Home, Browse, Saved, Emergency, Settings
- Icons: `house.fill`, `square.grid.2x2.fill`, `bookmark.fill`, `phone.fill`, `gearshape.fill`
- Selected: teal, unselected: white @ 60%
- Tab bar hides when keyboard is visible
- Background: black @ 90% with safe area extension

### Browse Navigation Flow

```
Browse Grid (2-col LazyVGrid)
  → Category List (grid or list view, species filter chips)
    → Entry Detail (full article with all sections)
```

All navigation destinations registered at BrowseView root level.

### Category List View

**Toolbar actions:**
- Sort toggle: severity (triangle icon) vs alphabetical (abc icon)
- Grid size cycle: 1 → 2 → 3 columns (only in grid view)
- View mode: grid ↔ list
- Custom back button ("Browse")

**Grid view:** 1-3 column LazyVGrid with square thumbnail images, rounded corners (12pt).

**List view:** Rows with 50x50 thumbnail, name, 2-line description, severity badge, chevron.

### Contextual Swipe Navigation

Three levels of swipe behavior from MainTabView's unified DragGesture:

| Context | Swipe Left | Swipe Right | Visual Feedback |
|---------|------------|-------------|-----------------|
| **Tab level** | Next tab | Previous tab (or Quick Emergency from Home) | Adjacent tab preview slides in |
| **Category list** | Next category | Previous category | None (instant) |
| **Entry detail** | Next entry | Previous entry | None (instant) |

**Thresholds:**
- Tab swipes: 20% screen width OR velocity > 200
- Entry/category swipes: 10% screen width OR velocity > 100

**Swipe blocking:** During swipe animations, `isSwipeBlocking` flag disables NavigationLink taps to prevent accidental navigation.

### Entry Detail Navigation Arrows

When opened from a category list (has context), left/right chevron arrows appear in the header. These provide visual affordance that swipe navigation is available.

- Left arrow: visible when `canSwipeToPreviousEntry`
- Right arrow: visible when `canSwipeToNextEntry`
- Not shown when opened from search or related entries (no context)

---

## Screen Layouts

### Home Tab (SearchView)

```
┌─────────────────────────────┐
│ [Pet Hero badge]  [Share]   │  HomeHeader
│        🐾 Pet Toxic         │
│  "For When Curiosity..."    │
├─────────────────────────────┤
│ 🔍 Search foods, plants...  │  Search bar
├─────────────────────────────┤
│ Recent: "chocolate" ✕       │  Recent searches (if any)
├─────────────────────────────┤
│ [My Pets Section]      PRO  │  Pet carousel or upsell
├─────────────────────────────┤
│ [Lab Work Guide]       PRO  │  Promo card
├─────────────────────────────┤
│ [Medical Glossary]     PRO  │  Promo card
└─────────────────────────────┘
```

When searching: results replace cards. Each result row shows category icon → name + categories → severity badge.

### Browse Tab (BrowseView)

```
┌─────────────────────────────┐
│ "Pick your poison..."       │  Navigation title
├─────────────────────────────┤
│ 🔍 Search bar               │  Browse-scoped search
├─────────────────────────────┤
│ ┌──────┐  ┌──────┐         │
│ │🍴    │  │🌿    │         │  2-column category grid
│ │Foods │  │Plants│         │
│ │ (17) │  │ (48) │         │
│ └──────┘  └──────┘         │
│ ┌──────┐  ┌──────┐         │
│ │💊    │  │🫧    │         │
│ │Meds  │  │Clean │         │
│ └──────┘  └──────┘         │
│        ...                   │
├─────────────────────────────┤
│ [Medical Glossary Card] PRO │  Footer card
└─────────────────────────────┘
```

### Category List

```
┌─────────────────────────────┐
│ ← Browse    Plants   ⚠ ⊞ ≡ │  Back, title, sort/grid/view toggles
├─────────────────────────────┤
│ [Auto✓] [All] [🐕] [🐱]... │  Species filter chips (horizontal scroll)
│ 🐾 Showing: Dogs, Cats     │  Auto filter indicator
├─────────────────────────────┤
│ ┌──────┐  ┌──────┐         │  Grid mode (2-col default)
│ │ img  │  │ img  │         │
│ └──────┘  └──────┘         │
│ ┌──────┐  ┌──────┐         │
│ │ img  │  │ img  │         │
│ └──────┘  └──────┘         │
└─────────────────────────────┘
```

Or in list mode:

```
│ [thumb] Lily        [SEVERE]│
│         True lily species...│
│ [thumb] Sago Palm     [HIGH]│
│         Cycas revoluta...   │
```

### Entry Detail (ArticleDetailView)

```
┌─────────────────────────────┐
│ ◀ [     Entry Image      ] ▶│  Header with nav arrows
│     Plants · Holiday        │  Category badges
├─────────────────────────────┤
│ ⚠ This app provides...  ▼  │  Collapsible disclaimer (yellow)
├─────────────────────────────┤
│ Risk by Species             │
│ 🐕 Dogs          [SEVERE]  │  SeveritySection
│   Dogs are commonly...      │
│ 🐱 Cats          [HIGH]    │
│   Cats are more sensitive...│
├─────────────────────────────┤
│ What is it?                 │
│ Chocolate is made from...   │  GlossaryStyledText
│ [📖 3 glossary terms  ▼]   │  GlossaryDropdownView (Pro)
├─────────────────────────────┤
│ Why is it toxic?            │
│ Contains theobromine...     │  GlossaryStyledText
├─────────────────────────────┤
│ Symptoms                    │
│ • Vomiting                  │  SymptomsListView
│ • Restlessness...           │
├─────────────────────────────┤
│ When Symptoms Appear        │
│ ⏱ Early: 30-60 minutes...  │  Onset time section
│ ⏳ Delayed: 17.5-hour...   │
├─────────────────────────────┤
│ Prevention Tips             │
│ 🛡 Store chocolate in...   │  Bulleted prevention list
├─────────────────────────────┤
│ 📞 Contact Poison Control  │
│ [ASPCA: 888-426-4435]      │  PoisonControlButton (red)
│ [Pet Poison: 855-764-7661] │
├─────────────────────────────┤
│ Related Entries             │
│ [Cocoa Mulch           →]  │  RelatedEntryButton
│ [Caffeine              →]  │
├─────────────────────────────┤
│ [📖 Medical Glossary]  PRO │  GlossaryEntryLink
├─────────────────────────────┤
│ ▶ Sources                  │  Collapsible DisclosureGroup
│   • ASPCA Animal Poison... │
│   • Pet Poison Helpline    │
└─────────────────────────────┘
```

**Toolbar:** Bookmark toggle (heart icon) + Share button.

### Emergency Tab

```
┌─────────────────────────────┐
│ Emergency                   │
├─────────────────────────────┤
│ [Pet Info Card]        PRO  │  EmergencyPetInfoCard
│  Pet selector + vet info    │
├─────────────────────────────┤
│ Contact Poison Control      │
│ Time is critical...         │
├─────────────────────────────┤
│ ┌─────────────────────────┐ │
│ │ 📞 ASPCA Animal Poison  │ │  Large red button
│ │    888-426-4435         │ │
│ └─────────────────────────┘ │
│ ┌─────────────────────────┐ │
│ │ 📞 Pet Poison Helpline  │ │  Large red button
│ │    855-764-7661         │ │
│ └─────────────────────────┘ │
├─────────────────────────────┤
│ ℹ Consultation fees may... │
├─────────────────────────────┤
│ What to Have Ready          │
│ ☑ Your pet's weight & age  │
│ ☑ Name of substance        │
│ ☑ Time of exposure         │
│ ☑ Symptoms observed        │
└─────────────────────────────┘
```

### Settings Tab

```
┌─────────────────────────────┐
│ Settings                    │
├─────────────────────────────┤
│ PRO FEATURES                │
│ [Upgrade to Pro]       →    │  or "Upgrade to Pet Hero"
│ [My Pets]              →    │  Pro only (upsell for free)
│ [Medical Glossary]     →    │  Pro only
│ [Lab Work Guide]       →    │  Pro only
├─────────────────────────────┤
│ PURCHASES                   │
│ [Restore Purchases]         │
├─────────────────────────────┤
│ ABOUT                       │
│ ▶ About Pet Toxic           │  DisclosureGroup
├─────────────────────────────┤
│ SHARE                       │
│ [Share Pet Toxic]      →    │
├─────────────────────────────┤
│ Disclaimer text...          │
├─────────────────────────────┤
│ v2026.02.12                 │  Tappable for debug (5× tap)
└─────────────────────────────┘
```

---

## Species Filter UI

Horizontal scrollable chip bar at top of CategoryListView:

```
[✨ Auto ✓] [All] [🐕 Dogs] [🐱 Cats] [🐦 Birds] [🐇 Small Mammals] [🦎 Reptiles]
```

- Selected chip: teal background, white text, semibold
- Unselected chip: white @ 10% background, gray text
- Pill-shaped (cornerRadius: 16)
- 44pt touch target (12pt vertical padding)

**Auto filter indicator:** When Auto is selected and pets are configured, shows "Showing: Dogs, Cats" in teal below chips. When no pets configured, shows "Add pets in Settings to personalize" in secondary color.

---

## SeverityBadge

Colored pill showing toxicity level. Three size variants:

| Size | Font | Padding H | Padding V |
|------|------|-----------|-----------|
| Small | caption | 8pt | 4pt |
| Medium | subheadline | 12pt | 6pt |
| Large | headline | 16pt | 8pt |

Colors match severity (green → yellow → gold → orange → red). Informational entries have no badge or show gray.

---

## Disclaimer Patterns

### In-Article Disclaimer (DisclaimerView)
- Yellow background (#FFF3CD) with orange border (#FFECB5)
- Collapsible with chevron
- Always visible at top of article — user never needs to scroll to see it
- Expanded shows 3 paragraphs of legal text

### Launch Disclaimer (DisclaimerPopupView)
- Full-screen overlay on first launch or version update
- Checks `@AppStorage("disclaimerAcknowledgedVersion")`
- "I Understand" button to dismiss
- Non-dismissible (no swipe/gesture to close)

---

## Poison Control Buttons

Two styles:

**Compact** (in articles):
```
[📞 ASPCA Animal Poison Control  888-426-4435  >]
```
Inline layout with phone icon, name, number, chevron.

**Large** (Emergency tab):
```
┌────────────────────────────────┐
│      📞                        │
│  ASPCA Animal Poison Control   │
│      888-426-4435              │
└────────────────────────────────┘
```
Full-width, prominent red button with large phone icon.

Both trigger `tel://` URL scheme on tap.

---

## Share Functionality

**Share sheet** triggered from ArticleDetailView toolbar:
- Generates formatted text with entry name, key info, and app link
- Renders 1024x1024 share card image via `ImageRenderer` (ShareCardView)
- App link: `https://apps.apple.com/app/pet-toxic/id6758074515`
- Share message: "Check out Pet Toxic — a quick reference for pet poison safety!"

---

## IAP Gating UI

### Free Users See
- Cards at reduced opacity (60%) with lock icon
- "PRO" badge (teal, pill-shaped)
- Tap triggers upsell alert → navigates to UpgradeView

### Pro Users See
- Full opacity, teal checkmark instead of lock
- Normal interaction enabled
- No upsell prompts

### Upgrade View (UpgradeView)
Two tier cards:
- **Pro card**: Feature list + price + buy button
- **Pet Hero card**: "POPULAR" badge + description + price + buy button
- Dynamic pricing from StoreKit (fallback: $9.99 / $14.99)
- Progress spinner during purchase
- Success/error alerts

---

## Glossary Integration in Articles

### GlossaryDropdownView
Collapsible section showing glossary terms found in article text:
- Header: "📖 X glossary terms" with expand chevron
- Collapsed: hidden
- Expanded: shows ~3.5 terms with fixed max height
- "Show all" button if more terms exist
- Each term: name + 3-line truncated definition + "Show more/less"
- Free users: locked appearance, tap → upsell

### GlossaryStyledText
Renders article text with inline glossary highlighting:
- Recognized terms colored teal (first occurrence only)
- Whole-word matching with word-boundary detection
- Combined with bold markdown rendering
- Combined with yellow search highlighting (when searching)
- Paragraphs split on `\n\n` → separate Text views in VStack(spacing: 12)

---

## Accessibility

| Feature | Implementation |
|---------|---------------|
| Touch targets | 44pt minimum via frame/padding modifiers |
| VoiceOver | `accessibilityLabel` on icon-only buttons |
| Combined elements | `accessibilityElement(children: .combine)` for composite views |
| Dynamic Type | Standard SwiftUI font sizes (system-managed) |
| High contrast | Dark background + light text throughout |
| Color + text | Severity always shown as text + color (not color alone) |

---

## Background & Gradient

`AppBackground` component used on every screen:

```swift
LinearGradient(
    colors: [Color(hex: "1A3A3A"), Color(hex: "0D1F1F")],
    startPoint: .top,
    endPoint: .bottom
)
.ignoresSafeArea()
```

Glossary and Lab Work Guide views use a teal-blue gradient variant for visual distinction.

---

## Quick Emergency Mode

Special navigation shortcut from Home tab:
- Right swipe on Home tab triggers Emergency overlay
- Tab bar keeps "Home" highlighted (visual anchor)
- Tapping any tab exits quick emergency mode
- Provides instant access to poison control without tab switching

---

## CategoryGridItem Design

```
┌──────────────────┐
│                  │
│     🍴 (icon)    │  SF Symbol, title3 size
│                  │
│     Foods        │  Category name, 2-line max
│     (17)         │  Item count, caption, gray
│                  │
└──────────────────┘
```

- Secondary background color
- Rounded corners (12pt)
- Minimum 44pt touch target
- 2-column grid with 16pt spacing

---

## My Pets UI

### Home Section (MyPetsHomeSection)

Three states:
1. **Free**: ProUpsellCard (locked, grayed)
2. **Pro, no pets**: "Add your first pet" card with plus icon
3. **Pro, with pets**: Horizontal avatar carousel + expandable detail card

**Pet carousel:** Circular avatars (scrollable), tap to select/deselect. Selected pet shows expanded card below with species, breed, weight, age, vet info, and "View Full Profile" button.

### Pet Form (PetFormView)

Sectioned form:
1. **Photo**: Circular avatar with camera/library picker
2. **Basic Info**: Name, nickname, species picker, breed autocomplete, sex picker
3. **Physical**: Weight (lbs/kg toggle), birthday (exact or approximate)
4. **Medical**: Microchip, vet clinic, vet phone (with call button), notes
5. **Case Numbers**: Add/list poison control case numbers with copy/delete
6. **Browse Filter**: Toggle for auto-filter prioritization

Auto-save with "Saved" indicator that appears briefly after changes.

---

## Debug Features

Hidden Developer Options in Settings (DEBUG builds only):
- Unlock: 5 rapid taps on version number
- Pro override toggle
- Pet Hero override toggle
- "Hide" button to re-lock

---

*Generated from live codebase — February 2026*
