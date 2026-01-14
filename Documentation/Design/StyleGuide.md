# Pet Toxic - Style Guide

Visual design reference for consistent UI implementation.

---

## Color Palette

### Primary Colors
| Name | Hex | Usage |
|------|-----|-------|
| Primary Teal | #4A9B9B | Buttons, links, active states |
| Background | #F8F9FA | Screen backgrounds |
| Surface | #FFFFFF | Cards, sheets |
| Text Primary | #333333 | Body text, headings |
| Text Secondary | #666666 | Captions, metadata |

### Severity Colors
| Level | Hex | RGB |
|-------|-----|-----|
| Low | #90EE90 | 144, 238, 144 |
| Moderate | #FFD700 | 255, 215, 0 |
| High | #FFA500 | 255, 165, 0 |
| Severe | #FF4444 | 255, 68, 68 |

### Semantic Colors
| Purpose | Light Mode | Dark Mode |
|---------|------------|-----------|
| Disclaimer Background | #FFF3CD | #5C4A1F |
| Disclaimer Border | #FFECB5 | #7A6429 |
| Error | #DC3545 | #F5A3A9 |
| Success | #28A745 | #7DD98A |

---

## Typography

Use San Francisco (system font) throughout for iOS consistency.

### Type Scale
| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| Large Title | 34pt | Bold | Screen titles |
| Title 1 | 28pt | Bold | Section headers |
| Title 2 | 22pt | Bold | Card titles |
| Title 3 | 20pt | Semibold | Subsection headers |
| Headline | 17pt | Semibold | List row titles |
| Body | 17pt | Regular | Body text |
| Callout | 16pt | Regular | Secondary info |
| Subheadline | 15pt | Regular | Metadata |
| Footnote | 13pt | Regular | Captions |
| Caption | 12pt | Regular | Timestamps |

### SwiftUI Implementation
```swift
// Use semantic styles, not hardcoded sizes
Text("Item Name")
    .font(.headline)

Text("Category")
    .font(.subheadline)
    .foregroundStyle(.secondary)
```

---

## Spacing

Use 8pt grid system.

| Token | Value | Usage |
|-------|-------|-------|
| xs | 4pt | Tight spacing, inline elements |
| sm | 8pt | Related elements |
| md | 16pt | Standard padding |
| lg | 24pt | Section spacing |
| xl | 32pt | Major sections |

### SwiftUI Implementation
```swift
// Standard padding
.padding()  // 16pt all sides

// Custom spacing
.padding(.horizontal, 16)
.padding(.vertical, 8)

// Stack spacing
VStack(spacing: 8) { ... }
```

---

## Component Specifications

### Buttons

**Primary Button:**
- Background: Primary Teal
- Text: White, Semibold
- Corner radius: 10pt
- Height: 50pt
- Horizontal padding: 24pt

**Emergency Call Button:**
- Background: #DC3545 (red)
- Text: White, Bold
- Corner radius: 12pt
- Height: 60pt minimum
- Full width

**Chip/Filter Button:**
- Background: #E9ECEF (unselected), Primary Teal (selected)
- Text: Text Primary (unselected), White (selected)
- Corner radius: 16pt (pill shape)
- Height: 32pt
- Horizontal padding: 12pt

### Cards

- Background: Surface (white)
- Corner radius: 12pt
- Shadow: 0, 2pt blur, 4pt spread, #000000 @ 8% opacity
- Padding: 16pt

### Severity Badge

- Corner radius: 8pt (pill)
- Horizontal padding: 8pt
- Vertical padding: 4pt
- Text: 12pt, Semibold, White
- Background: Severity color

### Search Bar

- Background: #E9ECEF
- Corner radius: 10pt
- Height: 44pt
- Icon: magnifyingglass, secondary color
- Placeholder: "Search foods, plants, medications..."

---

## Iconography

Use SF Symbols for consistency with iOS.

### Tab Bar Icons
| Tab | Symbol |
|-----|--------|
| Search | magnifyingglass |
| Browse | square.grid.2x2 |
| Saved | bookmark |
| Emergency | phone.fill |

### Category Icons
| Category | Symbol |
|----------|--------|
| Foods | fork.knife |
| Plants | leaf |
| Human Medications | pills |
| Cleaning Products | bubbles.and.sparkles |
| Essential Oils | drop |
| Garage & Automotive | car |
| Garden Products | shovel |
| Recreational Substances | exclamationmark.triangle |
| Holiday Hazards | gift |

### Action Icons
| Action | Symbol |
|--------|--------|
| Bookmark (empty) | bookmark |
| Bookmark (filled) | bookmark.fill |
| Share | square.and.arrow.up |
| Call | phone.fill |
| Back | chevron.left |
| Disclosure | chevron.right |

---

## Accessibility

### Touch Targets
- Minimum: 44pt × 44pt
- Emergency buttons: 60pt minimum height

### Dynamic Type
- Support all text sizes
- Test with largest accessibility sizes
- Use `@ScaledMetric` for custom spacing that scales

```swift
@ScaledMetric var iconSize: CGFloat = 24
```

### Color Contrast
- Text on backgrounds: minimum 4.5:1 ratio
- Large text (18pt+): minimum 3:1 ratio
- Test with Increase Contrast enabled

### VoiceOver
- All images need accessibility labels
- Severity badges should read as "Severity: High"
- Call buttons: "Call ASPCA Poison Control, 888-426-4435"

---

## Dark Mode

Support system dark mode with semantic colors.

```swift
// Use semantic colors that adapt
.foregroundStyle(.primary)
.foregroundStyle(.secondary)
.background(Color(.systemBackground))
.background(Color(.secondarySystemBackground))
```

For custom colors, define both light and dark variants in Assets.xcassets.

---

## Animation

Keep animations subtle and purposeful.

| Animation | Duration | Curve |
|-----------|----------|-------|
| Button press | 0.1s | easeOut |
| Screen transition | 0.3s | easeInOut |
| List row appear | 0.2s | easeOut |
| Badge pulse (severe) | 1.0s | easeInOut, repeat |

```swift
.animation(.easeInOut(duration: 0.3), value: isVisible)
```
