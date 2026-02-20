//
//  NavigationContext.swift
//  PetToxic
//
//  Created by Claude Code on 2/3/26.
//

import SwiftUI

/// A ToxicItem opened from a category list, carrying its source category.
/// Used as a distinct NavigationPath element so SwiftUI doesn't confuse it
/// with plain ToxicItem entries opened from search results.
struct CategoryEntry: Hashable {
    let item: ToxicItem
    let sourceCategory: Category
}

/// A ToxicItem opened from a severity list, carrying its source severity group.
struct SeverityEntry: Hashable {
    let item: ToxicItem
    let sourceSeverityGroup: SeverityGroupLevel
}

/// Tracks navigation state within the Browse tab to enable context-aware swipe gestures.
/// When the user is viewing a category list or entry detail, swipe gestures navigate
/// within that context rather than switching tabs.
@Observable
class BrowseNavigationContext {

    // MARK: - Navigation State

    /// Navigation depth: 0 = grid, 1 = category list, 2 = entry detail
    var depth: Int = 0

    /// Current category being viewed (nil when at grid level or in severity mode)
    var currentCategory: Category? = nil

    /// Current severity group being viewed (nil when not in severity mode)
    var currentSeverityGroup: SeverityGroupLevel? = nil

    /// Current entry index within visibleEntries (nil when not viewing entry)
    var currentEntryIndex: Int? = nil

    /// The actual sorted/filtered entry list the user sees.
    /// Must be updated whenever sort/filter changes in CategoryListView.
    var visibleEntries: [ToxicItem] = []

    /// Whether the current entry was opened with context (from category list).
    /// Entries opened from search or related links have no context.
    var hasContext: Bool = false

    /// Species filter selection — persisted across entry detail navigation within the same category.
    /// Resets when entering a different category or returning to the grid.
    var selectedSpeciesFilter: SpeciesFilter = .auto

    // MARK: - Computed Properties: Navigation Level

    var isAtGridLevel: Bool { depth == 0 }
    var isAtCategoryLevel: Bool { depth == 1 }
    var isAtEntryLevel: Bool { depth == 2 }
    var isSeverityMode: Bool { currentSeverityGroup != nil }

    // MARK: - Computed Properties: Entry Navigation

    var canSwipeToPreviousEntry: Bool {
        guard hasContext, let index = currentEntryIndex else { return false }
        return index > 0
    }

    var canSwipeToNextEntry: Bool {
        guard hasContext, let index = currentEntryIndex else { return false }
        return index < visibleEntries.count - 1
    }

    var previousEntry: ToxicItem? {
        guard canSwipeToPreviousEntry, let index = currentEntryIndex else { return nil }
        return visibleEntries[index - 1]
    }

    var nextEntry: ToxicItem? {
        guard canSwipeToNextEntry, let index = currentEntryIndex else { return nil }
        return visibleEntries[index + 1]
    }

    // MARK: - Computed Properties: Category Navigation

    var canSwipeToPreviousCategory: Bool {
        guard let category = currentCategory else { return false }
        let categories = Category.allCases
        guard let index = categories.firstIndex(of: category) else { return false }
        return index > categories.startIndex
    }

    var canSwipeToNextCategory: Bool {
        guard let category = currentCategory else { return false }
        let categories = Category.allCases
        guard let index = categories.firstIndex(of: category) else { return false }
        return categories.index(after: index) < categories.endIndex
    }

    var previousCategory: Category? {
        guard let category = currentCategory else { return nil }
        let categories = Category.allCases
        guard let index = categories.firstIndex(of: category), index > categories.startIndex else { return nil }
        return categories[categories.index(before: index)]
    }

    var nextCategory: Category? {
        guard let category = currentCategory else { return nil }
        let categories = Category.allCases
        guard let index = categories.firstIndex(of: category) else { return nil }
        let next = categories.index(after: index)
        guard next < categories.endIndex else { return nil }
        return categories[next]
    }

    var currentCategoryIndex: Int? {
        guard let category = currentCategory else { return nil }
        return Category.allCases.firstIndex(of: category).map { Category.allCases.distance(from: Category.allCases.startIndex, to: $0) }
    }

    // MARK: - Computed Properties: Severity Group Navigation

    var canSwipeToPreviousSeverityGroup: Bool {
        guard let group = currentSeverityGroup else { return false }
        let groups = SeverityGroupLevel.allCases
        guard let index = groups.firstIndex(of: group) else { return false }
        return index > groups.startIndex
    }

    var canSwipeToNextSeverityGroup: Bool {
        guard let group = currentSeverityGroup else { return false }
        let groups = SeverityGroupLevel.allCases
        guard let index = groups.firstIndex(of: group) else { return false }
        return groups.index(after: index) < groups.endIndex
    }

    var previousSeverityGroup: SeverityGroupLevel? {
        guard let group = currentSeverityGroup else { return nil }
        let groups = SeverityGroupLevel.allCases
        guard let index = groups.firstIndex(of: group), index > groups.startIndex else { return nil }
        return groups[groups.index(before: index)]
    }

    var nextSeverityGroup: SeverityGroupLevel? {
        guard let group = currentSeverityGroup else { return nil }
        let groups = SeverityGroupLevel.allCases
        guard let index = groups.firstIndex(of: group) else { return nil }
        let next = groups.index(after: index)
        guard next < groups.endIndex else { return nil }
        return groups[next]
    }

    // MARK: - State Update Methods

    /// Called when user navigates to a category list from the Browse grid.
    func enterCategoryList(category: Category, entries: [ToxicItem]) {
        // Only reset filter when entering a different category
        if self.currentCategory != category {
            self.selectedSpeciesFilter = .auto
        }
        self.depth = 1
        self.currentCategory = category
        self.visibleEntries = entries
        self.currentEntryIndex = nil
        self.hasContext = true
    }

    /// Called when user navigates to a severity list from the Browse grid.
    func enterSeverityList(severityGroup: SeverityGroupLevel, entries: [ToxicItem]) {
        if self.currentSeverityGroup != severityGroup {
            self.selectedSpeciesFilter = .auto
        }
        self.depth = 1
        self.currentSeverityGroup = severityGroup
        self.currentCategory = nil
        self.visibleEntries = entries
        self.currentEntryIndex = nil
        self.hasContext = true
    }

    /// Called when the visible entries list changes (due to sort/filter changes).
    func updateVisibleEntries(_ entries: [ToxicItem]) {
        // If we're viewing an entry, find its new index in the updated list
        if let currentIndex = currentEntryIndex, currentIndex < visibleEntries.count {
            let currentEntry = visibleEntries[currentIndex]
            self.visibleEntries = entries
            if let newIndex = entries.firstIndex(where: { $0.id == currentEntry.id }) {
                self.currentEntryIndex = newIndex
            }
        } else {
            self.visibleEntries = entries
        }
    }

    /// Called when user navigates to an entry detail from a category list.
    func enterEntryDetail(entry: ToxicItem) {
        self.depth = 2
        if let index = visibleEntries.firstIndex(where: { $0.id == entry.id }) {
            self.currentEntryIndex = index
        }
    }

    /// Called when user navigates to an entry without context (search, related link).
    func enterEntryDetailWithoutContext() {
        self.depth = 2
        self.hasContext = false
        self.currentEntryIndex = nil
    }

    /// Called when user returns to category list from entry detail.
    func returnToCategoryList() {
        self.depth = 1
        self.currentEntryIndex = nil
    }

    /// Called when user returns to Browse grid.
    func returnToGrid() {
        self.depth = 0
        self.currentCategory = nil
        self.currentSeverityGroup = nil
        self.currentEntryIndex = nil
        self.visibleEntries = []
        self.hasContext = false
        self.selectedSpeciesFilter = .auto
    }

    /// Navigates to a specific entry by index (used for swipe navigation).
    func navigateToEntryAtIndex(_ index: Int) {
        guard index >= 0 && index < visibleEntries.count else { return }
        self.currentEntryIndex = index
    }

    /// Full reset - clears all navigation state.
    func reset() {
        returnToGrid()
    }
}
