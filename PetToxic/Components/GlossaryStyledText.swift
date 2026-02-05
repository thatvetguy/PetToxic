//
//  GlossaryStyledText.swift
//  PetToxic
//
//  Created by Claude Code on 2/3/26.
//

import SwiftUI

/// Text component that highlights glossary terms in teal and supports search highlighting.
/// Splits content on paragraph breaks (\n\n) so SwiftUI renders visible spacing between paragraphs.
struct GlossaryStyledText: View {
    let content: String
    let searchTerm: String?  // For search highlighting (existing feature)

    private let glossaryTerms: [GlossaryTerm]
    private let paragraphs: [String]

    init(content: String, searchTerm: String? = nil) {
        self.content = content
        self.searchTerm = searchTerm
        self.glossaryTerms = GlossaryService.shared.findTerms(in: content)
        self.paragraphs = content
            .components(separatedBy: "\n\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    var body: some View {
        if paragraphs.count <= 1 {
            Text(attributedContent(for: content))
        } else {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(paragraphs.enumerated()), id: \.offset) { _, paragraph in
                    Text(attributedContent(for: paragraph))
                }
            }
        }
    }

    private func attributedContent(for text: String) -> AttributedString {
        // Start with markdown parsing
        var attributed = (try? AttributedString(markdown: text)) ?? AttributedString(text)

        // Apply glossary teal color (do this first, before search highlight)
        for term in glossaryTerms {
            // Highlight main term
            applyTealColor(to: &attributed, for: term.term)

            // Also highlight searchKeywords if they appear in the text
            if let keywords = term.searchKeywords {
                for keyword in keywords {
                    applyTealColor(to: &attributed, for: keyword)
                }
            }
        }

        // Apply search highlighting (if search active) — yellow background
        if let searchTerm = searchTerm, searchTerm.count >= 3 {
            applySearchHighlight(to: &attributed, for: searchTerm)
        }

        return attributed
    }

    /// Applies teal foreground color to the FIRST whole-word occurrence of a term
    private func applyTealColor(to attributed: inout AttributedString, for term: String) {
        let plainText = String(attributed.characters).lowercased()
        let searchTerm = term.lowercased()

        // Search for whole word matches only, highlight first occurrence
        var searchStart = plainText.startIndex
        while let range = plainText.range(of: searchTerm, range: searchStart..<plainText.endIndex) {
            // Check word boundaries
            let isStartBoundary = range.lowerBound == plainText.startIndex ||
                !plainText[plainText.index(before: range.lowerBound)].isLetter
            let isEndBoundary = range.upperBound == plainText.endIndex ||
                !plainText[range.upperBound].isLetter

            if isStartBoundary && isEndBoundary {
                // Found a whole word match — highlight it and stop
                if let attrRange = Range(range, in: attributed) {
                    attributed[attrRange].foregroundColor = .teal
                }
                return  // Only highlight first occurrence
            }

            // Not a whole word match, keep searching
            searchStart = range.upperBound
        }
    }

    /// Applies yellow background for search term highlighting
    private func applySearchHighlight(to attributed: inout AttributedString, for term: String) {
        let plainText = String(attributed.characters).lowercased()
        let searchLower = term.lowercased()

        var searchStart = plainText.startIndex
        while let range = plainText.range(of: searchLower, range: searchStart..<plainText.endIndex) {
            if let attrRange = Range(range, in: attributed) {
                attributed[attrRange].backgroundColor = .yellow.opacity(0.3)
            }
            searchStart = range.upperBound
        }
    }
}

// MARK: - Previews

#Preview("Glossary Terms Only") {
    ZStack {
        Color(red: 0.0, green: 0.22, blue: 0.32)
            .ignoresSafeArea()

        VStack(alignment: .leading, spacing: 20) {
            Text("No search term — glossary terms in teal:")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))

            GlossaryStyledText(
                content: "Chocolate contains methylxanthines which cause tachycardia, tremors, and seizures in pets.",
                searchTerm: nil
            )
            .foregroundColor(.white.opacity(0.9))

            Divider()
                .background(Color.white.opacity(0.3))

            Text("Text with no glossary terms:")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))

            GlossaryStyledText(
                content: "This is regular text with no medical terminology.",
                searchTerm: nil
            )
            .foregroundColor(.white.opacity(0.9))
        }
        .padding()
    }
}

#Preview("With Search Highlighting") {
    ZStack {
        Color(red: 0.0, green: 0.22, blue: 0.32)
            .ignoresSafeArea()

        VStack(alignment: .leading, spacing: 20) {
            Text("Search for 'chocolate' — yellow bg + teal glossary terms:")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))

            GlossaryStyledText(
                content: "Chocolate contains methylxanthines which cause tachycardia, tremors, and seizures in pets.",
                searchTerm: "chocolate"
            )
            .foregroundColor(.white.opacity(0.9))

            Divider()
                .background(Color.white.opacity(0.3))

            Text("Search for 'seizures' — both teal AND yellow:")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))

            GlossaryStyledText(
                content: "Chocolate contains methylxanthines which cause tachycardia, tremors, and seizures in pets.",
                searchTerm: "seizures"
            )
            .foregroundColor(.white.opacity(0.9))
        }
        .padding()
    }
}

#Preview("Markdown Support") {
    ZStack {
        Color(red: 0.0, green: 0.22, blue: 0.32)
            .ignoresSafeArea()

        VStack(alignment: .leading, spacing: 20) {
            Text("Markdown formatting preserved:")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))

            GlossaryStyledText(
                content: "**Chocolate toxicity** causes *tachycardia* and can lead to seizures. The methylxanthines are the toxic compounds.",
                searchTerm: nil
            )
            .foregroundColor(.white.opacity(0.9))
        }
        .padding()
    }
}

#Preview("Multi-Paragraph Spacing") {
    ZStack {
        Color(red: 0.0, green: 0.22, blue: 0.32)
            .ignoresSafeArea()

        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Paragraphs should have visible spacing:")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))

                GlossaryStyledText(
                    content: "First paragraph about chocolate toxicity and methylxanthines.\n\nSecond paragraph with more details about tachycardia and seizures.\n\n**IMPORTANT:** Third paragraph with bold header and critical information.",
                    searchTerm: nil
                )
                .font(.body)
                .lineSpacing(4)
                .foregroundColor(.white.opacity(0.9))
            }
            .padding()
        }
    }
}
