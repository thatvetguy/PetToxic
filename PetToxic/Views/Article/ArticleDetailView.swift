import SwiftUI

struct ArticleDetailView: View {
    let item: ToxicItem
    var saveSearchTerm: Bool = false
    @StateObject private var viewModel = ArticleViewModel()
    @State private var isBookmarked = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header with image and title
                headerSection

                // Disclaimer - Always visible first
                DisclaimerView()

                // Species risks
                if !item.speciesRisks.isEmpty {
                    SeveritySection(speciesRisks: item.speciesRisks)
                }

                // Description
                section(title: "What is it?") {
                    Text(formatSectionText(item.description))
                        .font(.body)
                        .lineSpacing(4)
                }

                // Toxicity info
                section(title: "Why is it toxic?") {
                    Text(formatSectionText(item.toxicityInfo))
                        .font(.body)
                        .lineSpacing(4)
                }

                // Symptoms
                section(title: "Symptoms to watch for") {
                    SymptomsListView(symptoms: item.symptoms)
                }

                // Onset time (if available)
                if let onsetTime = item.onsetTime {
                    onsetTimeSection(onsetTime)
                }

                // Prevention tips (if available)
                if let preventionTips = item.preventionTips, !preventionTips.isEmpty {
                    preventionTipsSection(preventionTips)
                }

                // Emergency contacts
                emergencySection

                // Related entries
                relatedEntriesSection

                // Sources
                sourcesSection
            }
            .padding()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 16) {
                    ShareLink(item: shareText) {
                        Image(systemName: "square.and.arrow.up")
                    }

                    Button {
                        isBookmarked.toggle()
                        viewModel.toggleBookmark(for: item)
                    } label: {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    }
                }
            }
        }
        .onAppear {
            isBookmarked = viewModel.isBookmarked(item)
            viewModel.recordView(of: item)
            if saveSearchTerm {
                SearchContext.shared.saveIfPending()
            }
        }
        .navigationDestination(for: ToxicItem.self) { relatedItem in
            ArticleDetailView(item: relatedItem)
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Category icon or image
            if let imageAsset = item.imageAsset {
                Image(imageAsset)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Image(systemName: item.categories.first?.icon ?? "questionmark.circle")
                    .font(.system(size: 60))
                    .foregroundStyle(Color("AccentColor"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
            }

            // Title and severity
            HStack {
                Text(item.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Spacer()

                if let maxSeverity = item.speciesRisks.map(\.severity).max(by: { severityOrder($0) < severityOrder($1) }) {
                    SeverityBadge(severity: maxSeverity, size: .large)
                }
            }

            // Categories
            Text(item.categories.map(\.displayName).joined(separator: " • "))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private func onsetTimeSection(_ onsetTime: OnsetTime) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("When Symptoms Appear")
                .font(.title2)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: 16) {
                if let early = onsetTime.early {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Early signs")
                            .font(.headline)
                            .foregroundStyle(Color("AccentColor"))
                        Text(early)
                            .font(.body)
                    }
                }

                if let delayed = onsetTime.delayed {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Delayed signs")
                            .font(.headline)
                            .foregroundStyle(.orange)
                        Text(delayed)
                            .font(.body)
                    }
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.vertical, 4)
    }

    private func preventionTipsSection(_ tips: [String]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Prevention Tips")
                .font(.title2)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: 8) {
                ForEach(tips, id: \.self) { tip in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "checkmark.shield.fill")
                            .foregroundStyle(.green)
                            .frame(width: 20)
                        Text(tip)
                            .font(.body)
                    }
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.vertical, 4)
    }

    private var emergencySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Contact Poison Control")
                .font(.title2)
                .fontWeight(.semibold)

            VStack(spacing: 12) {
                PoisonControlButton(contact: .aspca)
                PoisonControlButton(contact: .petPoisonHelpline)
            }
        }
        .padding(.vertical)
    }

    @ViewBuilder
    private var relatedEntriesSection: some View {
        if let relatedEntryIds = item.relatedEntries, !relatedEntryIds.isEmpty {
            let relatedItems = relatedEntryIds.compactMap { DatabaseService.shared.item(withIdString: $0) }
            if !relatedItems.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Related Entries")
                        .font(.title2)
                        .fontWeight(.semibold)

                    VStack(spacing: 8) {
                        ForEach(relatedItems) { relatedItem in
                            RelatedEntryButton(item: relatedItem)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }

    private var sourcesSection: some View {
        DisclosureGroup("Sources") {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(item.sources, id: \.self) { source in
                    Text("• \(source)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.top, 8)
        }
        .font(.subheadline)
    }

    private func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            content()
        }
        .padding(.vertical, 4)
    }

    private func severityOrder(_ severity: Severity) -> Int {
        switch severity {
        case .low: return 0
        case .moderate: return 1
        case .high: return 2
        case .severe: return 3
        }
    }

    private var shareText: String {
        generateShareText(for: item)
    }

    private func generateShareText(for item: ToxicItem) -> String {
        var text = ""

        // Header with warning emoji
        text += "⚠️ PET SAFETY ALERT: \(item.name)\n"
        text += String(repeating: "─", count: 40) + "\n\n"

        // Species Severities
        if !item.speciesRisks.isEmpty {
            text += "TOXICITY BY SPECIES:\n"
            for risk in item.speciesRisks {
                let severityEmoji: String
                switch risk.severity {
                case .low: severityEmoji = "🟢"
                case .moderate: severityEmoji = "🟡"
                case .high: severityEmoji = "🟠"
                case .severe: severityEmoji = "🔴"
                }
                text += "\(severityEmoji) \(risk.species.displayName): \(risk.severity.displayName.uppercased())"
                if let notes = risk.notes, !notes.isEmpty {
                    text += " — \(notes)"
                }
                text += "\n"
            }
            text += "\n"
        }

        // What Is It?
        text += "WHAT IS IT?\n"
        text += item.description + "\n\n"

        // Why Is It Dangerous?
        text += "WHY IS IT DANGEROUS?\n"
        text += item.toxicityInfo + "\n\n"

        // Onset Time (if present)
        if let onset = item.onsetTime {
            text += "WHEN DO SYMPTOMS APPEAR?\n"
            if let early = onset.early, !early.isEmpty {
                text += "• Early: \(early)\n"
            }
            if let delayed = onset.delayed, !delayed.isEmpty {
                text += "• Delayed: \(delayed)\n"
            }
            text += "\n"
        }

        // Symptoms
        if !item.symptoms.isEmpty {
            text += "SYMPTOMS TO WATCH FOR:\n"
            for symptom in item.symptoms {
                text += "• \(symptom)\n"
            }
            text += "\n"
        }

        // Prevention Tips (if present)
        if let tips = item.preventionTips, !tips.isEmpty {
            text += "PREVENTION TIPS:\n"
            for tip in tips {
                text += "• \(tip)\n"
            }
            text += "\n"
        }

        // Disclaimer
        text += String(repeating: "─", count: 40) + "\n"
        text += "⚠️ DISCLAIMER: This information is for educational purposes only and does not constitute veterinary medical advice. If your pet has been exposed to a potentially toxic substance, contact a licensed veterinarian or animal poison control center immediately.\n\n"

        // Emergency Contacts
        text += "🚨 EMERGENCY CONTACTS:\n"
        text += "• ASPCA Poison Control: (888) 426-4435\n"
        text += "• Pet Poison Helpline: (855) 764-7661\n"
        text += "(Consultation fees may apply)\n\n"

        // App Download Link
        text += String(repeating: "─", count: 40) + "\n"
        text += "📱 Download Pet Toxic — the complete poison guide for pet owners:\n"
        text += "[App Store link coming soon]\n\n"

        // Attribution
        text += "(Shared from Pet Toxic app)"

        return text
    }

    /// Formats text by detecting "ALL CAPS:" patterns and making them bold with paragraph breaks
    private func formatSectionText(_ text: String) -> AttributedString {
        // Pattern: 2+ capital letters (with optional spaces between words), followed by colon
        // Examples: "DRY BITES:", "SPECIES TOXICITY:", "WARNING:", "NOTE:"
        let pattern = #"[A-Z]{2,}(?:\s+[A-Z]+)*:"#

        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return AttributedString(text)
        }

        let nsRange = NSRange(text.startIndex..., in: text)
        let matches = regex.matches(in: text, options: [], range: nsRange)

        // If no matches, return plain text
        guard !matches.isEmpty else {
            return AttributedString(text)
        }

        var result = AttributedString()
        var currentIndex = text.startIndex

        for match in matches {
            guard let matchRange = Range(match.range, in: text) else { continue }

            // Add text before the match
            if currentIndex < matchRange.lowerBound {
                let precedingText = String(text[currentIndex..<matchRange.lowerBound])
                result += AttributedString(precedingText)
            }

            // Add paragraph break before header (if not at the very start of the text)
            if matchRange.lowerBound != text.startIndex {
                result += AttributedString("\n\n")
            }

            // Add the bold header
            var headerAttr = AttributedString(String(text[matchRange]))
            headerAttr.font = .body.bold()
            result += headerAttr

            currentIndex = matchRange.upperBound
        }

        // Add remaining text after last match
        if currentIndex < text.endIndex {
            let remainingText = String(text[currentIndex...])
            result += AttributedString(remainingText)
        }

        return result
    }
}

#Preview {
    NavigationStack {
        ArticleDetailView(item: .sample)
    }
}
