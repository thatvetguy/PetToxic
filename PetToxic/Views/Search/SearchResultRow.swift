import SwiftUI

struct SearchResultRow: View {
    let result: SearchResult

    var body: some View {
        HStack(spacing: 12) {
            // Category icon
            Image(systemName: result.item.categories.first?.icon ?? "questionmark.circle")
                .font(.title2)
                .foregroundStyle(.secondary)
                .frame(width: 32)

            // Content
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(result.item.name)
                        .font(.headline)

                    if result.item.categories.contains(.diseasesAndConditions) {
                        Text("PRO")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(Capsule().fill(Color.yellow.opacity(0.85)))
                    }
                }

                Text(result.item.categories.map(\.displayName).joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            // Severity badge
            if let severity = result.item.entrySeverity {
                SeverityBadge(severity: severity)
            } else if let maxSeverity = result.item.speciesRisks.map(\.severity).max() {
                SeverityBadge(severity: maxSeverity)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        SearchResultRow(result: SearchResult(
            item: .sample,
            relevanceScore: 1.0,
            matchType: .exact
        ))
    }
}
