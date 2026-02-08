import SwiftUI

struct ArticleDetailView: View {
    /// The item passed at initialization. May differ from the displayed item during swipe navigation.
    private let initialItem: ToxicItem
    var saveSearchTerm: Bool = false
    var searchQuery: String? = nil

    /// The category the user navigated from. Nil if opened from search or related entry link.
    /// Used for contextual swipe navigation (next/previous entry within category).
    var sourceCategory: Category? = nil

    init(item: ToxicItem, saveSearchTerm: Bool = false, searchQuery: String? = nil, sourceCategory: Category? = nil) {
        self.initialItem = item
        self.saveSearchTerm = saveSearchTerm
        self.searchQuery = searchQuery
        self.sourceCategory = sourceCategory
    }

    /// The currently displayed item. During swipe navigation within a category,
    /// returns the item at the current context index. Otherwise returns initialItem.
    private var item: ToxicItem {
        if sourceCategory != nil,
           navContext.hasContext,
           let index = navContext.currentEntryIndex,
           index >= 0, index < navContext.visibleEntries.count {
            return navContext.visibleEntries[index]
        }
        return initialItem
    }

    @StateObject private var viewModel = ArticleViewModel()
    @State private var isBookmarked = false
    @State private var showShareSheet = false
    @Environment(BrowseNavigationContext.self) private var navContext
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            AppBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header with image and title
                    headerSection

                    // Disclaimer - Always visible first
                    DisclaimerView()

                    // Species risks
                    if !item.speciesRisks.isEmpty {
                        SeveritySection(speciesRisks: item.speciesRisks, searchQuery: searchQuery)
                    }

                    // Description
                    section(title: "What is it?") {
                        GlossaryStyledText(content: item.description, searchTerm: searchQuery)
                            .font(.body)
                            .lineSpacing(4)
                        GlossaryDropdownView(
                            terms: GlossaryService.shared.findTerms(in: item.description)
                        )
                        .padding(.top, 8)
                    }

                    // Toxicity info
                    section(title: "Why is it toxic?") {
                        GlossaryStyledText(content: item.toxicityInfo, searchTerm: searchQuery)
                            .font(.body)
                            .lineSpacing(4)
                        GlossaryDropdownView(
                            terms: GlossaryService.shared.findTerms(in: item.toxicityInfo)
                        )
                        .padding(.top, 8)
                    }

                    // Symptoms
                    section(title: "Symptoms to watch for") {
                        SymptomsListView(symptoms: item.symptoms)
                        GlossaryDropdownView(
                            terms: GlossaryService.shared.findTerms(in: item.symptoms)
                        )
                        .padding(.top, 8)
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

                    // Medical Glossary link
                    GlossaryEntryLink()

                    // Sources
                    sourcesSection
                }
                .padding()
                .padding(.bottom, AppLayout.tabBarBottomPadding)
            }
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 16) {
                    Button {
                        showShareSheet = true
                    } label: {
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
            if sourceCategory != nil {
                navContext.enterEntryDetail(entry: item)
            } else {
                navContext.enterEntryDetailWithoutContext()
            }
        }
        .onChange(of: item.id) { _, _ in
            // When swipe navigation replaces the entry at the same depth,
            // SwiftUI may reuse this view without firing .onAppear.
            isBookmarked = viewModel.isBookmarked(item)
            viewModel.recordView(of: item)
            if sourceCategory != nil {
                navContext.enterEntryDetail(entry: item)
            } else {
                navContext.enterEntryDetailWithoutContext()
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: shareItems)
        }
        .navigationDestination(for: ToxicItem.self) { relatedItem in
            ArticleDetailView(item: relatedItem)
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Thumbnail image (includes entry name and severity color)
            if let imageAsset = item.imageAsset {
                Image(imageAsset)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            } else {
                Image(systemName: item.categories.first?.icon ?? "questionmark.circle")
                    .font(.largeTitle)
                    .foregroundStyle(Color("AccentColor"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
            }

            // Navigation arrows (only when browsing within a category)
            if sourceCategory != nil && navContext.hasContext &&
               (navContext.canSwipeToPreviousEntry || navContext.canSwipeToNextEntry) {
                HStack {
                    if navContext.canSwipeToPreviousEntry {
                        Button {
                            if let index = navContext.currentEntryIndex, index > 0 {
                                navContext.navigateToEntryAtIndex(index - 1)
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.5))
                                .frame(width: 44, height: 44)
                        }
                        .buttonStyle(.plain)
                    }

                    Spacer()

                    if navContext.canSwipeToNextEntry {
                        Button {
                            if let index = navContext.currentEntryIndex,
                               index < navContext.visibleEntries.count - 1 {
                                navContext.navigateToEntryAtIndex(index + 1)
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.5))
                                .frame(width: 44, height: 44)
                        }
                        .buttonStyle(.plain)
                    }
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
                        HighlightableMarkdownText(content: early, searchTerm: searchQuery)
                            .font(.body)
                    }
                }

                if let delayed = onsetTime.delayed {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Delayed signs")
                            .font(.headline)
                            .foregroundStyle(.orange)
                        HighlightableMarkdownText(content: delayed, searchTerm: searchQuery)
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
                ForEach(tips.filter { !$0.isEmpty }, id: \.self) { tip in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "checkmark.shield.fill")
                            .foregroundStyle(.green)
                            .frame(width: 20)
                        HighlightableMarkdownText(content: tip, searchTerm: searchQuery)
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

            Text("Pet Toxic is not affiliated with these organizations.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.top, 4)
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
        case .lowModerate: return 1
        case .moderate: return 2
        case .high: return 3
        case .severe: return 4
        }
    }

    private var shareItems: [Any] {
        var items: [Any] = []
        if let imageAssetName = item.imageAsset,
           let shareImage = renderShareImage(for: imageAssetName) {
            items.append(shareImage)
        }
        items.append(generateShareText(for: item))
        return items
    }

    @MainActor
    private func renderShareImage(for imageAssetName: String) -> UIImage? {
        let view = ShareCardView(imageAssetName: imageAssetName)
        let renderer = ImageRenderer(content: view)
        renderer.scale = 2.0
        return renderer.uiImage
    }

    private func generateShareText(for item: ToxicItem) -> String {
        var text = ""

        // Header with warning emoji
        text += "⚠️ PET SAFETY ALERT: \(item.name)\n"
        text += String(repeating: "─", count: 40) + "\n\n"

        // Species Severities
        if !item.speciesRisks.isEmpty {
            text += "TOXICITY BY SPECIES:\n"
            for risk in item.speciesRisks.sorted(by: { $0.species < $1.species }) {
                let severityEmoji: String
                switch risk.severity {
                case .low: severityEmoji = "🟢"
                case .lowModerate: severityEmoji = "🟡"
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

}

private struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    NavigationStack {
        ArticleDetailView(item: .sample)
    }
    .environment(BrowseNavigationContext())
}
