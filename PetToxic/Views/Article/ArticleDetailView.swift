import SwiftUI

struct ArticleDetailView: View {
    let item: ToxicItem
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
                SeveritySection(speciesRisks: item.speciesRisks)

                // Description
                section(title: "What is it?") {
                    Text(item.description)
                        .font(.body)
                }

                // Toxicity info
                section(title: "Why is it toxic?") {
                    Text(item.toxicityInfo)
                        .font(.body)
                }

                // Symptoms
                section(title: "Symptoms to watch for") {
                    SymptomsListView(symptoms: item.symptoms)
                }

                // Emergency contacts
                emergencySection

                // Sources
                sourcesSection
            }
            .padding()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isBookmarked.toggle()
                    viewModel.toggleBookmark(for: item)
                } label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                }
            }
        }
        .onAppear {
            isBookmarked = viewModel.isBookmarked(item)
            viewModel.recordView(of: item)
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
}

#Preview {
    NavigationStack {
        ArticleDetailView(item: .sample)
    }
}
