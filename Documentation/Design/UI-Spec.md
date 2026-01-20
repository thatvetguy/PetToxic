# Pet Toxic - UI Specification

Reference document for screens, navigation, and UI components.

---

## Tab Navigation

| Tab | Icon | Purpose |
|-----|------|---------|
| Search | magnifyingglass | Primary search with species filter |
| Browse | square.grid.2x2 | Category grid navigation |
| Saved | bookmark | Bookmarks and search history |
| Emergency | phone.fill | Poison control quick-dial |

---

## Screen Specifications

### 1. Search Screen (Home)

**Layout:**
- Large search bar at top (always visible, never scrolls away)
- Species filter chips below search bar (horizontally scrollable)
- Content area shows:
  - Recent searches (when search empty)
  - Results list (when searching)

**Search Result Row:**
- Item name (primary text)
- Category label (secondary text)
- Severity badge (colored indicator)
- Chevron for navigation

**Behavior:**
- Search triggers on text change (debounced 300ms)
- Species filter is additive (can select multiple)
- Tapping result navigates to Article Detail

---

### 2. Article Detail Screen

**Layout (top to bottom):**
1. Item image (if available) or category icon
2. Item name + severity badge
3. **Disclaimer box** (prominent, colored background)
4. Species risk section (show risk level per species)
5. "What is it?" section
6. "Why is it toxic?" section
7. "Symptoms to watch for" (bulleted list)
8. Poison control call buttons
9. Source citations (collapsed by default)

**Navigation Bar:**
- Back button (left)
- Bookmark toggle button (right)

**Critical:** Disclaimer must be visible without scrolling on standard iPhone sizes.

---

### 3. Browse Screen

**Layout:**
- 2-column grid of category cards
- Each card shows: icon, category name, item count

**Categories:**
1. Foods
2. Plants
3. Medications
4. Cleaning Products
5. Garage & Garden
6. Recreational Substances
7. Holiday Hazards
8. Environmental Hazards
9. Household Items
10. Other Hazards
11. Animal Encounters

**Behavior:**
- Tapping category shows filtered list of items in that category
- Category list uses same row style as search results

---

### 4. Saved Screen

**Layout:**
- Segmented control: Bookmarks | History
- List of items based on selection

**Bookmarks Tab:**
- List of bookmarked items
- Swipe to delete
- Empty state: "No bookmarks yet"

**History Tab:**
- Recent searches (text queries)
- Recent views (items viewed)
- Clear history button
- Empty state: "No history yet"

---

### 5. Emergency Screen

**Layout:**
- Header text: "Contact Poison Control"
- Large call button: ASPCA (888) 426-4435
- Large call button: Pet Poison Helpline (855) 764-7661
- Note about consultation fees
- "What to have ready" section:
  - Pet's species, breed, weight, age
  - Substance name and amount
  - Time of exposure
  - Current symptoms

**Behavior:**
- Call buttons use `tel:` URL scheme
- Buttons must be minimum 60pt tall for easy tapping in panic

---

## Required Disclaimer

Display on EVERY article page:

> **DISCLAIMER:** This information is for educational purposes only and does not constitute veterinary medical advice. If your pet has been exposed to a potentially toxic substance, contact a licensed veterinarian or animal poison control center immediately.

**Styling:**
- Yellow/amber background
- Dark text
- Rounded corners
- Padding all sides
- Cannot be dismissed or hidden

---

## Reusable Components

### SeverityBadge
- Pill-shaped badge
- Background color matches severity level
- White text: "Low", "Moderate", "High", "Severe"

### DisclaimerView
- Standardized disclaimer box
- Used on Article Detail and anywhere toxicity info shown

### PoisonControlButton
- Large tappable button
- Phone icon + organization name + phone number
- Triggers phone call on tap

### SpeciesFilterChip
- Toggleable chip for species selection
- Shows species icon + name
- Highlighted state when selected

---

## Empty States

| Screen | Empty State Message |
|--------|---------------------|
| Search results | "No results found. Try a different search term." |
| Bookmarks | "No bookmarks yet. Tap the bookmark icon on any article to save it." |
| History | "No history yet. Your recent searches and views will appear here." |
| Category list | "No items in this category yet." |
