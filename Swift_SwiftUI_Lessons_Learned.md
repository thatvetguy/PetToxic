# Swift & SwiftUI Lessons Learned

Practical development insights, bugs, gotchas, workarounds, and best practices from the PetToxic iOS app (200+ commits, 95+ Swift files, iOS 17.6+). Intended as reference material for new iOS projects.

---

## 1. SwiftUI Gotchas

### 1.1 NavigationPath Replacement Causes Bounce-Backs

**Issue:** Assigning a new `NavigationPath` to swap one entry for another at the same depth (lateral navigation) is unreliable. SwiftUI internally processes it as pop-then-push, causing bounce-back animations, transient intermediate states, or routing swipes to the wrong navigation level.

**Fix:** Never replace `NavigationPath` for lateral (same-depth) navigation. Keep the path stable and switch displayed content in-place via an `@Observable` context object. The `NavigationPath` should only change for structural navigation (push/pop depth levels).

```swift
// WRONG - causes bounce-backs
func swipeToNextEntry(_ nextEntry: ToxicItem) {
    var newPath = NavigationPath()
    newPath.append(nextEntry)
    navigationPath = newPath  // Pop-then-push internally
}

// RIGHT - update context, path stays stable
func swipeToNextEntry() {
    navContext.navigateToEntryAtIndex(currentIndex + 1)
    // ArticleDetailView reads from navContext.visibleEntries[currentEntryIndex]
}
```

**Why it matters:** This was the single biggest source of bugs in the project — 10+ sequential fix commits over 4 days before arriving at the stable architecture. Each fix revealed a new edge case (race conditions, stale flags, system gesture conflicts).

---

### 1.2 `.navigationDestination` Must Be on NavigationStack Root

**Issue:** Registering `.navigationDestination` modifiers on child views (e.g., inside a `CategoryListView`) means they're only available while that child is rendered. Programmatic `NavigationPath` changes resolve destinations from the root — if the child view re-renders or is not visible, the destination is lost.

**Fix:** Always register all `.navigationDestination` modifiers on the root view of the `NavigationStack`, not on child views.

```swift
NavigationStack(path: $navigationPath) {
    RootView()
        // ALL destinations registered here
        .navigationDestination(for: Category.self) { ... }
        .navigationDestination(for: CategoryEntry.self) { ... }
        .navigationDestination(for: SeverityEntry.self) { ... }
}
```

**Why it matters:** Silent failures — navigation links stop working with no error message.

---

### 1.3 SwiftUI View Reuse: `.onAppear` Doesn't Fire on Same-Depth Swap

**Issue:** When replacing a `NavigationPath` entry at the same depth (e.g., swapping categories), SwiftUI may reuse the existing view instance without calling `.onAppear`. State setup that depends on `.onAppear` becomes stale.

**Fix:** Always pair `.onAppear` with `.onChange(of:)` for the key property that identifies the content:

```swift
.onAppear {
    loadData(for: category)
}
.onChange(of: category) { _, _ in
    loadData(for: category)  // Fires when view is reused with new data
}
```

**Why it matters:** Stale data displayed after navigation — hard to debug because it works fine on first navigation.

---

### 1.4 ScrollView Competes with `.simultaneousGesture(DragGesture)`

**Issue:** Even with `.simultaneousGesture`, a vertical `ScrollView` can prevent `DragGesture.onChanged` from reliably setting state. The horizontality guard (`abs(horizontal) > abs(vertical) * 1.5`) fails because the `ScrollView` processes the gesture first and reports confusing intermediate values.

**Fix:** For swipes over `ScrollView` content, check the **final** `value.translation` in `onEnded` rather than relying on intermediate `onChanged` state:

```swift
.onEnded { value in
    if !isDragging {
        // ScrollView may have blocked onChanged — check final translation
        let horizontal = abs(value.translation.width)
        let vertical = abs(value.translation.height)
        guard horizontal > vertical else { return }
    }
    // Process the swipe...
}
```

**Why it matters:** Swipe gestures silently stop working over scrollable content.

---

### 1.5 Horizontal ScrollView Inside DragGesture Creates Gesture Conflict

**Issue:** A horizontal `ScrollView` (e.g., filter chips) inside a view with a `DragGesture` causes the drag gesture to intercept horizontal scrolling, preventing the `ScrollView` from working.

**Fix (attempt 1 — failed):** Adding `highPriorityGesture(DragGesture())` with an empty handler to the `ScrollView` to "eat" the gesture — this blocked scrolling entirely.

**Fix (working):** Use the gesture's `startLocation.y` to exclude drags originating in the `ScrollView`'s Y range:

```swift
.onChanged { value in
    let startY = value.startLocation.y
    if startY >= filterBarMinY && startY <= filterBarMaxY {
        return  // Let ScrollView handle horizontal scrolling
    }
    // Process drag...
}
```

**Why it matters:** Users can't interact with filter chips / horizontal scroll elements.

---

### 1.6 `.toolbar(placement: .keyboard)` Doesn't Work with `@Binding NavigationPath`

**Issue:** Adding a `.toolbar { ToolbarItemGroup(placement: .keyboard) { ... } }` to a view that receives a `@Binding NavigationPath` silently fails — the toolbar items never appear.

**Fix:** Remove the keyboard toolbar and use alternative approaches: `.scrollDismissesKeyboard(.interactively)`, a manual "Cancel" button, or `@FocusState` with programmatic dismissal.

**Why it matters:** The keyboard Done button is invisible — users have no way to dismiss the keyboard.

---

### 1.7 Keyboard Dismissal Has No Single Solution

**Issue:** SwiftUI has no comprehensive keyboard dismissal API. Each screen/context needs its own combination of approaches. This was a recurring pain point requiring 7+ commits across nearly every screen.

**Fix:** Use a combination per context:
- **ScrollView content:** `.scrollDismissesKeyboard(.interactively)` or `.scrollDismissesKeyboard(.immediately)`
- **Toolbar Done button:** `@FocusState` + `ToolbarItemGroup(placement: .keyboard)`
- **Tap-to-dismiss:** `.onTapGesture { focusState = nil }` (but see 1.8)
- **Tab bar hiding:** Use `UIResponder.keyboardWillShowNotification` / `keyboardWillHideNotification` via Combine:

```swift
.onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
    withAnimation(.easeOut(duration: 0.25)) {
        isKeyboardVisible = true
    }
}
```

**Why it matters:** Without comprehensive keyboard handling, users get trapped with the keyboard open and no way to dismiss it, or the keyboard covers important UI elements.

---

### 1.8 TapGesture Intercepts Picker/Control Taps

**Issue:** Adding a `.simultaneousGesture(TapGesture())` for keyboard dismissal intercepts taps on `Picker` rows and other form controls, preventing them from activating.

**Fix:** Remove the tap gesture entirely. Use `.scrollDismissesKeyboard(.interactively)` and/or `.safeAreaPadding(.bottom, 80)` to allow scrolling to dismiss instead.

**Why it matters:** Form controls become unresponsive — users can't select options.

---

### 1.9 Custom Tab Bar Must Hide When Keyboard Appears

**Issue:** A custom tab bar (using `.safeAreaInset(edge: .bottom)`) stays visible over the keyboard, blocking content and looking broken.

**Fix:** Track keyboard visibility and hide the tab bar:

```swift
.safeAreaInset(edge: .bottom) {
    customTabBar
        .opacity(isKeyboardVisible ? 0 : 1)
        .allowsHitTesting(!isKeyboardVisible)
}
```

**Why it matters:** Tab bar overlaps keyboard; taps on tab bar still fire even though it's visually behind the keyboard.

---

### 1.10 `AttributedString(markdown:)` Swallows Paragraph Breaks

**Issue:** `AttributedString(markdown:)` converts `\n\n` paragraph breaks into paragraph elements, but SwiftUI's `Text` renders them with **zero visible spacing**. Long text appears as a wall of text with no paragraph separation.

**Fix:** Split content on `\n\n` and render each paragraph as a separate `Text` inside a `VStack(spacing: 12)`:

```swift
var body: some View {
    let paragraphs = content
        .components(separatedBy: "\n\n")
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }

    if paragraphs.count <= 1 {
        Text(try! AttributedString(markdown: content))
    } else {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(paragraphs.enumerated()), id: \.offset) { _, paragraph in
                Text(try! AttributedString(markdown: paragraph))
            }
        }
    }
}
```

**Why it matters:** Multi-paragraph content becomes unreadable without visible paragraph breaks.

---

### 1.11 Two-Phase Animation for Content Swaps

**Issue:** Using `withAnimation { selectedTab = newTab }` to switch tab content causes SwiftUI to animate both the old and new content simultaneously, creating a visual flash or jarring transition.

**Fix:** Use two-phase animation — slide the current view off-screen first, then swap content after the animation completes:

```swift
// PHASE 1: Animate current view sliding off-screen
withAnimation(.easeOut(duration: 0.25)) {
    dragOffset = targetOffset
}

// PHASE 2: After animation completes, swap content instantly
DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
    selectedTab = newTab  // No animation wrapper — instant swap
    dragOffset = 0
    isDragging = false
}
```

**Why it matters:** Without this, tab changes have an abrupt flash as both views animate simultaneously.

---

### 1.12 DispatchQueue.main.asyncAfter Race Conditions During Rapid Gestures

**Issue:** When swiping rapidly, delayed cleanup timers from a previous swipe can fire during the next swipe, resetting `isDragging` and `dragOffset` mid-gesture and silently killing the new swipe.

**Fix:** Add an `isAnimatingTransition` guard flag that blocks all gesture recognition during animation:

```swift
@State private var isAnimatingTransition = false

DragGesture()
    .onChanged { value in
        guard !isAnimatingTransition else { return }
        // ...
    }
    .onEnded { value in
        guard !isAnimatingTransition else { return }
        isAnimatingTransition = true
        // ... animate ...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            isAnimatingTransition = false
        }
    }
```

**Why it matters:** Rapid swipes cause navigation to break or route to wrong destinations.

---

### 1.13 NavigationLink Fires During/After Swipe Gestures

**Issue:** A `NavigationLink` tap can fire during or immediately after a swipe gesture, causing accidental navigation when the user's finger lifts from a swipe.

**Fix:** Disable `NavigationLink` elements during swipes:

```swift
@State private var isSwipeBlocking = false

// In gesture.onChanged:
isSwipeBlocking = true

// In gesture.onEnded (after animation):
DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
    isSwipeBlocking = false
}

// On NavigationLinks:
NavigationLink(value: item) { ... }
    .disabled(isSwipeBlocking)
```

**Why it matters:** Accidental navigation after swipe gestures is confusing and frustrating for users.

---

### 1.14 Disabling System Edge-Swipe-to-Go-Back

**Issue:** The system's built-in edge-swipe-to-go-back gesture fires alongside custom `DragGesture`s, causing the `NavigationStack` to pop unexpectedly.

**Fix (attempt 1 — failed):** Using `UIViewControllerRepresentable` to disable `interactivePopGestureRecognizer` — SwiftUI's `NavigationStack` may not use a `UINavigationController` internally, so this doesn't work.

**Fix (working):** Use `.navigationBarBackButtonHidden(true)` with custom back buttons:

```swift
.navigationBarBackButtonHidden(true)
.toolbar {
    ToolbarItem(placement: .navigationBarLeading) {
        Button { dismiss() } label: {
            Image(systemName: "chevron.left")
        }
    }
}
```

**Why it matters:** System gesture conflicts cause unexpected navigation pops during custom gesture handling.

---

### 1.15 Contextual Swipes Need Different Thresholds

**Issue:** Using the same gesture threshold for all swipe contexts feels wrong — tab swipes (with visual preview) need higher thresholds to prevent accidental triggers, while entry flicks (no visual feedback) need lighter thresholds to feel responsive.

**Fix:** Select thresholds based on context:

```swift
let isContextualSwipe = navigationPath.count > 0

let threshold = isContextualSwipe
    ? screenWidth * 0.10   // ~40pt — light flick for entries
    : screenWidth * 0.20   // ~80pt — visual slide for tabs

let velocityThreshold: CGFloat = isContextualSwipe ? 100 : 200
```

**Why it matters:** One-size-fits-all thresholds make some swipe contexts feel too sensitive and others too sluggish.

---

### 1.16 `isPresented` Binding Adapter for Optional State

**Issue:** SwiftUI's `.alert(isPresented:)` requires a `Binding<Bool>`, but sometimes alert presentation depends on optional state (e.g., which product was purchased).

**Fix:** Create a custom `Binding` adapter:

```swift
.alert(
    purchasedProductID == "supporter" ? "Welcome, Pet Hero!" : "Welcome to Pro!",
    isPresented: Binding(
        get: { purchasedProductID != nil },
        set: { if !$0 { purchasedProductID = nil } }
    )
) { ... }
```

**Why it matters:** Avoids maintaining separate boolean flags that can get out of sync with the actual state.

---

## 2. SwiftData / Persistence

### 2.1 Double-Insert Bug with Relationship Arrays

**Issue:** When adding a child record to a parent's relationship array AND also calling `modelContext.insert()`, SwiftData creates duplicate records. SwiftData automatically tracks inserts through the relationship — the manual insert is redundant.

**Fix:** Only append to the relationship array. Do NOT call `modelContext.insert()`:

```swift
// WRONG - creates duplicate records
let newRecord = VaccinationRecord(vaccineName: name, pet: pet)
pet.vaccinationRecords.append(newRecord)
modelContext.insert(newRecord)  // ← REMOVE THIS

// RIGHT - SwiftData handles the insert
let newRecord = VaccinationRecord(vaccineName: name, pet: pet)
pet.vaccinationRecords.append(newRecord)
try? modelContext.save()
```

**Why it matters:** Duplicate records appear in the UI with no obvious cause; hard to debug.

---

### 2.2 Store Raw Values for Enums in SwiftData Models

**Issue:** SwiftData `@Model` classes can't directly store custom enum types as properties. Using enums directly causes compile-time or runtime errors.

**Fix:** Store the raw value (String) and use computed properties for type-safe access:

```swift
@Model
final class Pet {
    var species: String  // Raw value stored

    var speciesEnum: PetSpecies {
        get { PetSpecies(rawValue: species) ?? .canine }  // Default fallback
        set { species = newValue.rawValue }
    }
}
```

**Why it matters:** Avoids SwiftData serialization issues while maintaining type safety in the rest of the codebase.

---

### 2.3 @Query Returns Empty Array on Failure

**Issue/Behavior:** If a `@Query` fetch fails, it silently returns an empty array rather than throwing. This is actually convenient for UI code but can mask data issues.

**Good practice:** For critical operations, use manual `FetchDescriptor` with error handling:

```swift
func fetchPets() -> [Pet] {
    let descriptor = FetchDescriptor<Pet>(
        sortBy: [SortDescriptor(\.sortOrder), SortDescriptor(\.dateCreated)]
    )
    do {
        return try modelContext.fetch(descriptor)
    } catch {
        #if DEBUG
        print("Failed to fetch pets: \(error)")
        #endif
        return []
    }
}
```

---

### 2.4 Keychain Survives App Deletion; UserDefaults Does Not

**Issue:** If you store trial start dates or sensitive state in `UserDefaults` or `@AppStorage`, users can reset it by reinstalling the app.

**Fix:** Use Keychain for state that must persist across app deletion/reinstall:

```swift
// Write: Update-first pattern (avoids duplicates)
let updateStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
if updateStatus == errSecItemNotFound {
    SecItemAdd(addQuery as CFDictionary, nil)
}

// Read: Standard query
var result: AnyObject?
let status = SecItemCopyMatching(query as CFDictionary, &result)
```

Use ISO8601 date format for date values stored in Keychain.

**Why it matters:** Trial timers, subscription state, and other tamper-resistant data must survive reinstall.

---

## 3. Xcode & Build Issues

### 3.1 SourceKit False Positives After File Edits

**Issue:** After editing files (especially batch edits), SourceKit diagnostics report errors like "Cannot find type in scope" or "Ambiguous use of init." These are false positives caused by SourceKit analyzing files in isolation without full project context.

**Fix:** Ignore SourceKit diagnostics in the editor. Always verify with an actual build:

```bash
xcodebuild -scheme PetToxic -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

**Why it matters:** False positives waste time investigating non-issues and can cause unnecessary "fixes" that break working code.

---

### 3.2 macOS BSD `awk` Doesn't Support Capture Groups

**Issue:** macOS ships with BSD `awk`, which does NOT support `match()` with capture groups (3rd argument). Scripts using `match($0, /pattern/, arr)` will fail silently or error.

**Fix:** Use `gsub()` to extract values instead, or use `gawk` if installed. Alternatively, use `perl -ne` for complex text extraction.

---

### 3.3 SF Symbol Compatibility Varies by iOS Version

**Issue:** Newer SF Symbols cause runtime crashes on older iOS versions. There's no compile-time warning.

**Fix:** Before using any SF Symbol, verify it exists in your minimum deployment target version.

Known iOS 18+ only symbols (will crash on iOS 17):
- `liver.fill`, `stomach.fill`, `testtube.2`

Safe alternatives for medical/science contexts:
- `cross.vial.fill`, `staroflife.fill`, `drop.triangle.fill`, `plus.forwardslash.minus`

**Verification:** Check existing codebase usage with `grep "systemName"` to find patterns known to work.

---

### 3.4 Hardcoded UUID Collisions in Data

**Issue:** When manually creating UUIDs for hardcoded data entries, copy-paste errors can create duplicate UUIDs. One entry shadows the other silently — no crash, just wrong data displayed.

**Fix:** After adding entries, verify UUID uniqueness. Use different UUID prefixes or a generation script. The project had a case where Superglue and Cocoa Mulch shared the same UUID.

**Why it matters:** Extremely hard to debug — the app works fine but shows wrong content for one of the colliding entries.

---

### 3.5 Data Model Field Order Matters for Readability

**Issue:** When hardcoding 160+ data entries in Swift, inconsistent field order makes auditing and editing extremely error-prone. Several entries had fields in wrong positions (e.g., `onsetTime` and `symptoms` swapped), causing silent data corruption.

**Fix:** Establish and enforce a strict field order for data model initializers. Document it prominently. A single commit fixed 14 entries with incorrect field order.

---

## 4. Swift Language Pitfalls

### 4.1 Boolean Flags Are Unreliable Across SwiftUI Runloop Cycles

**Issue:** Using boolean flags (e.g., `isProgrammaticNavigation`) to communicate state between parent and child views is fragile. SwiftUI's `NavigationStack` can emit transient path states across multiple runloop cycles, so no timing-based flag clearing reliably prevents race conditions.

**Fix:** Use delayed verification instead of flags. When observing state changes, wait briefly, then re-check:

```swift
// WRONG - flag approach is fragile
isProgrammaticNavigation = true
navigationPath = newPath
// Child clears flag in onAppear, but parent's onChange fires first

// RIGHT - delayed verification
onChange(of: navigationPath.count) { _, newCount in
    if newCount == 0 {
        // Wait, then verify it's genuinely zero (not transient)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            if browseNavigationPath.count == 0 {
                navContext.returnToGrid()
            }
        }
    }
}
```

**Why it matters:** The project tried the flag approach, discovered it was "fundamentally fragile" (exact commit message), and replaced it after multiple race condition fixes.

---

### 4.2 `[weak self]` in Combine Sink Closures

**Issue:** Combine `.sink` closures retain `self` strongly by default, creating retain cycles with ViewModel instances that store `cancellables`.

**Fix:** Always use `[weak self]` in `.sink` closures:

```swift
$searchText
    .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
    .removeDuplicates()
    .sink { [weak self] query in
        Task {
            await self?.performSearch(query: query)
        }
    }
    .store(in: &cancellables)
```

---

### 4.3 Use `.compactMap` for Optional ID Resolution

**Issue:** Arrays of UUID strings referencing other entities may contain stale or invalid IDs. Force-unwrapping lookups will crash.

**Fix:** Use `.compactMap` to silently drop unresolvable references:

```swift
let relatedItems = relatedEntryIds.compactMap { idString in
    DatabaseService.shared.item(withIdString: idString)
}
// Gracefully handles deleted/missing entries
```

---

### 4.4 `Comparable` Conformance for Consistent Enum Sorting

**Issue:** Enums used for display (e.g., species, severity) show in arbitrary order unless explicitly sorted. With 160+ entries each containing 5 species, inconsistent display order is jarring.

**Fix:** Add `Comparable` conformance with explicit `sortOrder`:

```swift
enum Species: String, Comparable {
    case dog, cat, smallMammal, bird, reptile

    private var sortOrder: Int {
        switch self {
        case .dog: return 0
        case .cat: return 1
        case .smallMammal: return 2
        case .bird: return 3
        case .reptile: return 4
        }
    }

    static func < (lhs: Species, rhs: Species) -> Bool {
        lhs.sortOrder < rhs.sortOrder
    }
}

// Sort at display layer, not data layer
ForEach(speciesRisks.sorted { $0.species < $1.species }) { risk in ... }
```

**Why it matters:** Display-layer sorting is better than reordering all data entries — one line of code vs. editing hundreds of entries.

---

### 4.5 Filter Empty Strings at Display Layer

**Issue:** Empty strings (`""`) in data arrays (symptoms, tips) render as blank bullet points in the UI.

**Fix:** Filter at the display layer rather than editing all data entries:

```swift
ForEach(item.symptoms.filter { !$0.isEmpty }, id: \.self) { symptom in
    Text("• \(symptom)")
}
```

---

## 5. App Architecture Patterns

### 5.1 @Observable for Cross-View State (Recommended)

**What worked:** Using `@Observable` (Swift 5.9+) for navigation context that needs reactive updates across 4+ view hierarchy levels. Injected via `@Environment`, no property drilling needed.

```swift
@Observable
class BrowseNavigationContext {
    var depth: Int = 0
    var currentCategory: Category? = nil
    var currentEntryIndex: Int? = nil
    var visibleEntries: [ToxicItem] = []
    // Computed properties derive UI state from these values
}

// Injection (App root)
.environment(browseNavigationContext)

// Access (any child view)
@Environment(BrowseNavigationContext.self) private var navContext
```

**Why @Observable over @Published:** No `@Published` property wrappers needed, no `@StateObject` in every view, cleaner syntax (`navContext.depth` vs. `$navContext.depth`).

---

### 5.2 Singleton Services with @Published (Works Well)

**What worked:** `@MainActor` singleton services with `@Published` state for app-level concerns (bookmarks, settings, trial state):

```swift
@MainActor
class BookmarkService: ObservableObject {
    static let shared = BookmarkService()
    @Published var bookmarks: [ToxicItem] = []
    private init() { loadBookmarks() }
}
```

Access via `@ObservedObject private var bookmarkService = BookmarkService.shared`.

**Key:** `@MainActor` guarantees all state mutations happen on main thread — eliminates manual `.receive(on: RunLoop.main)`.

---

### 5.3 Wrapper Types for Navigation Context

**What worked:** Creating distinct wrapper types to carry source context through `NavigationPath`:

```swift
struct CategoryEntry: Hashable {
    let item: ToxicItem
    let sourceCategory: Category
}

struct SeverityEntry: Hashable {
    let item: ToxicItem
    let sourceSeverityGroup: SeverityGroupLevel
}
```

This prevents type collisions in `NavigationPath` and tells the destination view where the user came from (enabling context-aware features like swipe navigation).

---

### 5.4 Debounced Search with Separate Filter Subscriptions

**What worked:** Two separate Combine subscriptions — one debounced for text input, one immediate for filter changes:

```swift
// Text changes: debounce 300ms (user is typing)
$searchText
    .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
    .removeDuplicates()
    .sink { [weak self] query in Task { await self?.performSearch(query: query) } }
    .store(in: &cancellables)

// Filter changes: immediate (user made deliberate choice)
$selectedSpecies
    .sink { [weak self] _ in
        guard let self = self, !self.searchText.isEmpty else { return }
        Task { await self.performSearch(query: self.searchText) }
    }
    .store(in: &cancellables)
```

**Why separate:** Users expect immediate response to filter taps but tolerance for typing delays.

---

### 5.5 Forward objectWillChange Between Dependent Managers

**What worked:** When a computed property depends on another `ObservableObject`'s state, forward the change signal:

```swift
class ProSettings: ObservableObject {
    var isPro: Bool {
        _purchasedPro || TrialManager.shared.isTrialActive  // Depends on TrialManager
    }

    private init() {
        TrialManager.shared.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()  // Forward notification
            }
            .store(in: &cancellables)
    }
}
```

Without this, views observing `ProSettings.isPro` won't update when the trial expires.

---

### 5.6 Display-Layer Transformations Over Data-Layer Changes

**What worked well:** Applying sorting (`.sorted()`), filtering (`.filter()`), and formatting at the view/display layer rather than modifying hundreds of hardcoded data entries.

Examples:
- Species sort order: `.sorted { $0.species < $1.species }` in `SeveritySection`
- Empty string filtering: `.filter { !$0.isEmpty }` in symptom lists
- Default values: `PetSpecies(rawValue: species) ?? .canine`

**Why:** One line of display code is better than editing 160+ data entries, especially for cosmetic changes.

---

### 5.7 Persistence Layering Strategy

**What worked:** Different persistence backends for different data types:

| Data Type | Backend | Why |
|-----------|---------|-----|
| User preferences | `@AppStorage` / UserDefaults | Simple key-value, auto-syncs |
| Bookmarks / history | UserDefaults (UUID arrays) | Simple lists, reconstructed from in-memory DB |
| Trial start date | Keychain | Survives app deletion; tamper-resistant |
| Pet profiles | SwiftData | Relational data with cascading deletes |
| Toxicity data | In-memory (hardcoded) | Offline-first; planned SQLite migration |

---

## 6. Third-Party Dependencies

### 6.1 Minimal Dependencies Strategy

**What worked:** The project uses zero third-party dependencies. Everything is built with native frameworks:
- **UI:** SwiftUI
- **Data:** SwiftData
- **Search:** Custom relevance scoring (SQLite FTS5 planned)
- **Persistence:** Keychain Services, UserDefaults
- **Purchases:** StoreKit 2

**Why this matters:** No dependency management overhead, no version conflicts, no supply chain risk. For a reference app that must work offline, fewer dependencies means fewer failure modes.

---

### 6.2 StoreKit Configuration Gotcha

**Issue:** `Product.products(for:)` returns an empty array with no error when the StoreKit configuration file isn't selected in Edit Scheme → Run → Options → StoreKit Configuration.

**Fix:** Add a debug warning when products array is empty:

```swift
#if DEBUG
if storeProducts.isEmpty {
    print("WARNING — 0 products returned. Verify the .storekit config file is selected.")
}
#endif
```

---

## 7. App Store / TestFlight

### 7.1 Dynamic Type Replacement Pass

**Issue:** 18 hardcoded font sizes (48pt, 36pt, 28pt, etc.) across 14 files were flagged for accessibility compliance. Apple requires Dynamic Type support.

**Fix:** Replace all hardcoded sizes with Dynamic Type text styles:

| Hardcoded | Replacement |
|-----------|-------------|
| 48pt | `.largeTitle` |
| 36pt | `.title` |
| 28pt | `.title2` |
| 24pt | `.title3` |
| 20pt | `.callout` |
| 18pt | `.body` |
| 14pt | `.footnote` |

**Exception:** Decorative elements below ~8pt (bullet dots) don't need text styles.

---

### 7.2 UIKit API Replacements

**Issue:** Several UIKit APIs should be replaced with SwiftUI equivalents for App Store compliance and future-proofing:

| UIKit Pattern | SwiftUI Replacement |
|---------------|---------------------|
| `UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder))` | `.scrollDismissesKeyboard(.immediately)` + `@FocusState` |
| `UIApplication.shared.open(url)` | `@Environment(\.openURL) var openURL` |
| Hardcoded `Color(red:green:blue:)` | Centralized `AppColors` constants or Asset Catalog colors |

---

### 7.3 Minimum Touch Targets (44pt)

**Issue:** Apple Human Interface Guidelines require 44pt minimum touch targets. Small buttons and interactive elements will be flagged in App Store review.

**Fix:** Apply `.frame(minHeight: 44)` to all interactive elements:

```swift
Button { ... } label: {
    HStack {
        Image(systemName: "chevron.left")
        Text(previousItem.name)
    }
    .frame(minHeight: 44)  // Accessibility compliance
}
```

---

### 7.4 VoiceOver Element Combination

**Issue:** Complex UI components (icon + text + chevron) are read as separate elements by VoiceOver, creating a confusing experience.

**Fix:** Use `.accessibilityElement(children: .combine)` to group related elements:

```swift
HStack {
    Image(systemName: "exclamationmark.triangle.fill")
    Text("Disclaimer text...")
    Image(systemName: "chevron.down")
}
.accessibilityElement(children: .combine)  // Read as single element
```

---

### 7.5 AI-Generated Image Disclaimer

**Lesson:** If using AI-generated images in your app, include a clear disclaimer visible to users. App Store reviewers may flag AI imagery that could be confused with real products/brands.

---

## 8. General Recommendations

### 8.1 Self-Healing Documentation

**What worked:** Treating `CLAUDE.md` as a living knowledge base where platform-specific errors, tool incompatibilities, and gotchas are documented as they're discovered. Each session that encounters a new issue adds a note, so future sessions don't repeat the mistake.

**Recommendation:** Start every project with a CLAUDE.md/README that includes a "Gotchas" section and actively update it throughout development.

---

### 8.2 Word Boundary Matching for Text Highlighting

**Issue:** Substring matching for glossary/search highlighting matched "ate" inside "chocolate" and "do" inside "window."

**Fix:** Implement word boundary checking:

```swift
func findWholeWord(_ term: String, in text: String) -> Range<String.Index>? {
    let lowered = text.lowercased()
    let search = term.lowercased()
    var start = lowered.startIndex

    while let range = lowered.range(of: search, range: start..<lowered.endIndex) {
        let isStartBoundary = range.lowerBound == lowered.startIndex ||
            !lowered[lowered.index(before: range.lowerBound)].isLetter
        let isEndBoundary = range.upperBound == lowered.endIndex ||
            !lowered[range.upperBound].isLetter

        if isStartBoundary && isEndBoundary {
            return range  // Whole word match
        }
        start = range.upperBound
    }
    return nil
}
```

**Also:** Ensure search term matching and highlighting use the **same** boundary logic — mismatches cause terms to be found but not highlighted (or vice versa).

---

### 8.3 Avoid Overly Broad Search Keywords

**Issue:** Common words in search keyword arrays ("do", "not", "yellow", anatomy terms like "liver", "kidney") cause excessive false-positive matches. This required 8+ commits to fix iteratively.

**Fix:** Review all search keywords for:
- Words that are substrings of common terms
- Anatomy terms that appear in many entry descriptions
- Function words ("do", "not", "is", "the")

Remove or replace with more specific alternatives.

---

### 8.4 Debug Overrides for Subscription/Trial State

**What worked:** `#if DEBUG` toggles for subscription state, allowing testing of all purchase/trial states without actual transactions:

```swift
#if DEBUG
@AppStorage("debug_pro_enabled") private var _debugProEnabled: Bool = false

func resetTrial() {
    deleteStartDate()
    expirationAlertShown = false
    objectWillChange.send()
}

func setExpiringSoon() {
    let date = Calendar.current.date(byAdding: .day, value: -27, to: Date())!
    writeStartDate(date)
}
#endif
```

**Recommendation:** Build these from day one. Testing subscription flows without debug overrides is extremely tedious.

---

### 8.5 UIActivityViewController Bridge for Share Sheet

**What worked:** Wrapping UIKit's `UIActivityViewController` in a `UIViewControllerRepresentable` for native share functionality:

```swift
private struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
```

For share images, use `ImageRenderer` (must run on `@MainActor`):

```swift
@MainActor
private func renderShareImage(for view: some View) -> UIImage? {
    let renderer = ImageRenderer(content: view)
    renderer.scale = 2.0
    return renderer.uiImage
}
```

---

### 8.6 Guard Clauses Over Nested Conditionals

**Pattern observed throughout:** Fail-fast with guard clauses rather than nesting conditions:

```swift
// Good
guard !isAnimatingTransition else { return }
guard hasContext, let index = currentEntryIndex else { return false }
guard index >= 0 && index < visibleEntries.count else { return }

// Avoid
if !isAnimatingTransition {
    if hasContext {
        if let index = currentEntryIndex {
            // deeply nested logic
        }
    }
}
```

---

### 8.7 Nil Coalescing for Sorting Optional Values

**Pattern:** Use sentinel values when sorting arrays with optional properties:

```swift
let dateA = a.nextDueDate ?? .distantFuture
let dateB = b.nextDueDate ?? .distantFuture
return dateA < dateB
// Records without due dates sort to the bottom
```

---

### 8.8 Color Consolidation

**Issue:** 15 instances of `Color(red: 0.29, green: 0.61, blue: 0.61)` scattered across 8 files.

**Fix:** Consolidate into a single constant:

```swift
enum AppColors {
    static let teal = Color(red: 0.29, green: 0.61, blue: 0.61)
}
```

Do this from the start. Colors, fonts, and spacing constants should be centralized before they proliferate.

---

### 8.9 Multi-Line String Literals for Long Content

**What worked:** Using triple-quoted strings with natural blank lines for multi-paragraph content:

```swift
// Good — natural paragraph breaks
let description = """
First paragraph about the substance.

Second paragraph with details.

Third paragraph with warnings.
"""

// Also works — explicit escape sequences
let description = "First paragraph.\n\nSecond paragraph."

// Avoid — mixing escapes inside triple-quotes (creates 4 newlines)
let description = """
First paragraph.\n\nSecond paragraph.
"""
```

---

### 8.10 Relevance Scoring for Search Results

**What worked:** Position-based base score with bonuses for match quality:

| Match Type | Bonus |
|------------|-------|
| Exact name match | +50 |
| Name prefix match | +25 |
| Alternate name contains | +10 |
| Position decay | 100 - position |

Simple but effective — gives users the most relevant results first without complex algorithms.

---

*Generated from PetToxic project analysis — February 2026*
