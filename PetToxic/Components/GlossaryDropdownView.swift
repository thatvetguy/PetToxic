//
//  GlossaryDropdownView.swift
//  PetToxic
//
//  Created by Claude Code on 2/3/26.
//

import SwiftUI

struct GlossaryDropdownView: View {
    let terms: [GlossaryTerm]

    @State private var isExpanded = false
    @State private var expandedDefinitions: Set<UUID> = []  // Track which definitions are fully shown
    @State private var showAllTerms = false

    // MARK: - Constants

    private let maxVisibleTerms = 4
    private let collapsedHeight: CGFloat = 350  // ~3.5 definitions

    private var isPro: Bool {
        ProSettings.shared.isPro
    }

    var body: some View {
        if !terms.isEmpty {
            VStack(alignment: .leading, spacing: 0) {
                // Header (always visible)
                headerView

                // Expanded content (Pro only)
                if isExpanded && isPro {
                    expandedContent
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(isPro ? 0.08 : 0.04))
            )
            .animation(.easeInOut(duration: 0.25), value: isExpanded)
        }
    }

    // MARK: - Header

    private var headerView: some View {
        Button {
            if isPro {
                if isExpanded {
                    // Collapsing - reset showAllTerms
                    showAllTerms = false
                }
                isExpanded.toggle()
            }
            // Free users: button does nothing
        } label: {
            HStack {
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .font(.caption)
                    .foregroundColor(isPro ? .teal : .gray)

                (Text("View \(terms.count) ")
                    .foregroundColor(isPro ? .white : .gray) +
                Text("Glossary Term\(terms.count == 1 ? "" : "s")")
                    .foregroundColor(isPro ? .teal : .gray))
                    .font(.subheadline)
                    .fontWeight(.medium)

                Spacer()

                // Pro badge for free users
                if !isPro {
                    Text("Pro")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            Capsule()
                                .fill(Color.gray.opacity(0.4))
                        )
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
        }
        .disabled(!isPro)  // Prevent any interaction for free users
    }

    // MARK: - Expanded Content

    private var expandedContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
                .background(Color.white.opacity(0.2))
                .padding(.horizontal, 12)

            // Terms list - scrollable with fixed height or fully expanded
            if terms.count > maxVisibleTerms && !showAllTerms {
                // Fixed height with scroll
                ScrollView {
                    termsListContent
                }
                .frame(maxHeight: collapsedHeight)

                // "Show all" button
                showAllButton
            } else {
                // Show all terms (either few terms or user tapped "Show all")
                termsListContent

                // "Show less" button if we expanded from "Show all"
                if terms.count > maxVisibleTerms && showAllTerms {
                    showLessButton
                }
            }

            Spacer().frame(height: 8)
        }
    }

    // MARK: - Terms List Content

    private var termsListContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(terms.enumerated()), id: \.element.id) { index, term in
                VStack(alignment: .leading, spacing: 4) {
                    // Term name + pronunciation
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        Text(term.term)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.teal)

                        if let pronunciation = term.pronunciation {
                            Text("(\(pronunciation))")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                                .italic()
                        }
                    }

                    // Definition with truncation
                    let isDefinitionExpanded = expandedDefinitions.contains(term.id)

                    Text(term.definition)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.85))
                        .lineLimit(isDefinitionExpanded ? nil : 3)
                        .fixedSize(horizontal: false, vertical: true)

                    // "Show more" / "Show less" button (only if definition is long)
                    if isDefinitionLong(term.definition) {
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                if isDefinitionExpanded {
                                    expandedDefinitions.remove(term.id)
                                } else {
                                    expandedDefinitions.insert(term.id)
                                }
                            }
                        } label: {
                            Text(isDefinitionExpanded ? "Show less" : "Show more")
                                .font(.caption2)
                                .foregroundColor(.teal.opacity(0.8))
                        }
                        .padding(.top, 2)
                    }
                }
                .padding(.horizontal, 12)

                // Divider between terms (not after last)
                if index < terms.count - 1 {
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                }
            }
        }
        .padding(.top, 12)
    }

    // MARK: - Show All / Show Less Buttons

    private var showAllButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.25)) {
                showAllTerms = true
            }
        } label: {
            HStack {
                Spacer()
                Text("Show all \(terms.count) terms")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.teal)
                Image(systemName: "chevron.down")
                    .font(.caption2)
                    .foregroundColor(.teal)
                Spacer()
            }
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.05))
        }
    }

    private var showLessButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.25)) {
                showAllTerms = false
            }
        } label: {
            HStack {
                Spacer()
                Text("Show fewer terms")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.teal)
                Image(systemName: "chevron.up")
                    .font(.caption2)
                    .foregroundColor(.teal)
                Spacer()
            }
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.05))
        }
    }

    // MARK: - Helper

    /// Estimate if definition needs truncation (roughly 3+ lines)
    /// Using character count as proxy: ~150 chars ≈ 3 lines at caption font
    private func isDefinitionLong(_ definition: String) -> Bool {
        definition.count > 150
    }
}

#Preview("Pro User - Multiple Terms") {
    ZStack {
        Color(red: 0.0, green: 0.22, blue: 0.32)
            .ignoresSafeArea()

        ScrollView {
            VStack(spacing: 20) {
                // Terms with mixed definition lengths
                GlossaryDropdownView(terms: [
                    GlossaryTerm(
                        id: UUID(),
                        term: "Tachycardia",
                        pronunciation: "tak-ee-KAR-dee-ah",
                        definition: "Abnormally rapid heart rate. In dogs, a resting heart rate over 140 bpm (small dogs) or 100 bpm (large dogs) may indicate tachycardia. This is a common sign of stimulant toxicity and requires veterinary evaluation.",
                        category: .symptoms,
                        relatedTerms: nil,
                        searchKeywords: nil
                    ),
                    GlossaryTerm(
                        id: UUID(),
                        term: "Tremors",
                        pronunciation: nil,
                        definition: "Involuntary shaking or quivering of the body or limbs.",
                        category: .symptoms,
                        relatedTerms: nil,
                        searchKeywords: nil
                    ),
                    GlossaryTerm(
                        id: UUID(),
                        term: "Methemoglobinemia",
                        pronunciation: "met-HEE-moh-glo-bin-EE-mee-ah",
                        definition: "A condition where hemoglobin is converted to methemoglobin, which cannot carry oxygen effectively. This causes the blood to become brownish and leads to tissue hypoxia. Common causes include certain medications, chemicals, and foods like onions in pets. Signs include brown or muddy gum color, weakness, and difficulty breathing. Requires immediate veterinary treatment with methylene blue.",
                        category: .conditions,
                        relatedTerms: nil,
                        searchKeywords: nil
                    )
                ])

                // Single term
                GlossaryDropdownView(terms: [
                    GlossaryTerm(
                        id: UUID(),
                        term: "Seizures",
                        pronunciation: nil,
                        definition: "Sudden episodes of abnormal electrical activity in the brain causing convulsions.",
                        category: .symptoms,
                        relatedTerms: nil,
                        searchKeywords: nil
                    )
                ])

                // Empty terms (should not render)
                GlossaryDropdownView(terms: [])
            }
            .padding()
        }
    }
}

#Preview("Free User") {
    ZStack {
        Color(red: 0.0, green: 0.22, blue: 0.32)
            .ignoresSafeArea()

        VStack(spacing: 20) {
            GlossaryDropdownView(terms: [
                GlossaryTerm(
                    id: UUID(),
                    term: "Tachycardia",
                    pronunciation: "tak-ee-KAR-dee-ah",
                    definition: "Abnormally rapid heart rate.",
                    category: .symptoms,
                    relatedTerms: nil,
                    searchKeywords: nil
                ),
                GlossaryTerm(
                    id: UUID(),
                    term: "Tremors",
                    pronunciation: nil,
                    definition: "Involuntary shaking.",
                    category: .symptoms,
                    relatedTerms: nil,
                    searchKeywords: nil
                )
            ])

            Text("(Toggle isPro in ProSettings to test)")
                .font(.caption)
                .foregroundColor(.white.opacity(0.5))
        }
        .padding()
    }
}
