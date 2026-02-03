//
//  GlossaryTermDetailView.swift
//  PetToxic
//
//  Created by Claude Code on 2/2/26.
//

import SwiftUI

struct GlossaryTermDetailView: View {
    let term: GlossaryTerm

    private let glossaryService = GlossaryService.shared

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.0, green: 0.25, blue: 0.35),
                    Color(red: 0.0, green: 0.20, blue: 0.30),
                    Color(red: 0.0, green: 0.15, blue: 0.25)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Term header
                    termHeader

                    Divider()
                        .background(Color.white.opacity(0.3))

                    // Definition
                    definitionSection

                    // Related terms (if any)
                    if let relatedTerms = term.relatedTerms, !relatedTerms.isEmpty {
                        Divider()
                            .background(Color.white.opacity(0.3))

                        relatedTermsSection(relatedTerms)
                    }

                    // Category badge
                    categoryBadge

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
        }
        .navigationTitle(term.term)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(red: 0.0, green: 0.25, blue: 0.35), for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    // MARK: - Term Header

    private var termHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(term.term)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            if let pronunciation = term.pronunciation {
                Text(pronunciation)
                    .font(.title3)
                    .italic()
                    .foregroundColor(.white.opacity(0.7))
            }
        }
    }

    // MARK: - Definition Section

    private var definitionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Definition")
                .font(.headline)
                .foregroundColor(.teal)

            Text(term.definition)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .lineSpacing(4)
        }
    }

    // MARK: - Related Terms Section

    private func relatedTermsSection(_ relatedTerms: [String]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Related Terms")
                .font(.headline)
                .foregroundColor(.teal)

            VStack(spacing: 8) {
                ForEach(relatedTerms, id: \.self) { relatedTermName in
                    if let relatedTerm = glossaryService.term(named: relatedTermName) {
                        // Navigable link
                        NavigationLink(destination: GlossaryTermDetailView(term: relatedTerm)) {
                            relatedTermRow(name: relatedTermName, isLinked: true)
                        }
                    } else {
                        // Non-navigable (term not yet in glossary)
                        relatedTermRow(name: relatedTermName, isLinked: false)
                    }
                }
            }
        }
    }

    private func relatedTermRow(name: String, isLinked: Bool) -> some View {
        HStack {
            Text(name)
                .font(.subheadline)
                .foregroundColor(isLinked ? .white : .white.opacity(0.5))

            Spacer()

            if isLinked {
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(Color.white.opacity(isLinked ? 0.1 : 0.05))
        .cornerRadius(8)
    }

    // MARK: - Category Badge

    private var categoryBadge: some View {
        HStack {
            Image(systemName: term.category.icon)
                .font(.caption)

            Text(term.category.rawValue)
                .font(.caption)
        }
        .foregroundColor(.white.opacity(0.6))
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        GlossaryTermDetailView(term: GlossaryTerm(
            term: "Methemoglobinemia",
            pronunciation: "met-HEE-moh-glo-bin-EE-mee-ah",
            definition: "A condition where hemoglobin in red blood cells is converted to methemoglobin, which cannot carry oxygen effectively. The blood may appear chocolate-brown. Affected animals show blue or gray gums (cyanosis), weakness, and difficulty breathing.",
            category: .conditions,
            relatedTerms: ["Heinz Body Anemia", "Cyanosis"],
            searchKeywords: nil
        ))
    }
}
