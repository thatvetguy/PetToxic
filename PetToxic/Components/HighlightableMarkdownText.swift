import SwiftUI

struct HighlightableMarkdownText: View {
    let content: String
    let searchTerm: String?

    // Semi-transparent gold/yellow highlight visible against dark teal background
    private let highlightColor = Color.yellow.opacity(0.35)

    var body: some View {
        if let attributed = buildAttributedString() {
            Text(attributed)
        } else {
            Text(content)
        }
    }

    private func buildAttributedString() -> AttributedString? {
        guard var attributed = try? AttributedString(
            markdown: content,
            options: AttributedString.MarkdownParsingOptions(
                interpretedSyntax: .inlineOnlyPreservingWhitespace
            )
        ) else {
            return nil
        }

        // Minimum 3 characters for highlighting
        guard let searchTerm = searchTerm, searchTerm.count >= 3 else {
            return attributed
        }

        let plainText = String(attributed.characters)
        let searchLower = searchTerm.lowercased()
        let textLower = plainText.lowercased()

        var searchStartIndex = textLower.startIndex
        while let range = textLower.range(of: searchLower, range: searchStartIndex..<textLower.endIndex) {
            let startOffset = textLower.distance(from: textLower.startIndex, to: range.lowerBound)
            let endOffset = textLower.distance(from: textLower.startIndex, to: range.upperBound)

            let attrStart = attributed.index(attributed.startIndex, offsetByCharacters: startOffset)
            let attrEnd = attributed.index(attributed.startIndex, offsetByCharacters: endOffset)
            let attrRange = attrStart..<attrEnd

            attributed[attrRange].backgroundColor = highlightColor

            searchStartIndex = range.upperBound
        }

        return attributed
    }
}

#Preview {
    ZStack {
        Color(red: 0.1, green: 0.23, blue: 0.23)

        VStack(alignment: .leading, spacing: 20) {
            HighlightableMarkdownText(
                content: "**Privet** (Ligustrum spp.) is a common hedge plant. Privet berries are toxic to dogs.",
                searchTerm: "privet"
            )
            .foregroundColor(.white)

            HighlightableMarkdownText(
                content: "**Privet** (Ligustrum spp.) is a common hedge plant. Privet berries are toxic to dogs.",
                searchTerm: nil
            )
            .foregroundColor(.white)

            HighlightableMarkdownText(
                content: "Chocolate contains **theobromine** and caffeine.",
                searchTerm: "chocolate"
            )
            .foregroundColor(.white)
        }
        .padding()
    }
}
