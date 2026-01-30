import SwiftUI

struct SeveritySection: View {
    let speciesRisks: [SpeciesRisk]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Risk by Species")
                .font(.title2)
                .fontWeight(.semibold)

            VStack(spacing: 8) {
                ForEach(speciesRisks) { risk in
                    HStack {
                        Image(systemName: risk.species.icon)
                            .frame(width: 24)
                            .foregroundStyle(.secondary)

                        Text(risk.species.displayName)
                            .font(.body)
                            .fontWeight(.semibold)

                        Spacer()

                        SeverityBadge(severity: risk.severity)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    if let notes = risk.notes, !notes.isEmpty {
                        MarkdownText(content: notes)
                            .font(.callout)
                            .foregroundStyle(.primary)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SeveritySection(speciesRisks: [
        SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are particularly sensitive"),
        SpeciesRisk(species: .cat, severity: .moderate, notes: nil)
    ])
    .padding()
}
