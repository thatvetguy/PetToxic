import SwiftUI

struct MarkdownText: View {
    let content: String

    var body: some View {
        if let attributed = try? AttributedString(markdown: content, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)) {
            Text(attributed)
        } else {
            Text(content)
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        MarkdownText(content: "This has **bold** text")
        MarkdownText(content: "Normal text without formatting")
        MarkdownText(content: "**Theobromine** is the toxic compound")
    }
    .padding()
}
