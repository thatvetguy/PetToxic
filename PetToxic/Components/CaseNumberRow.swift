import SwiftUI

struct CaseNumberRow: View {
    let caseNumber: String
    let dateAdded: Date
    let note: String?
    let onCopy: () -> Void
    let onDelete: () -> Void

    @State private var showCopiedFeedback = false

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(caseNumber)
                    .font(.system(.body, design: .monospaced))
                    .fontWeight(.medium)
                    .foregroundColor(.primary)

                HStack(spacing: 8) {
                    Text(dateAdded, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if let note = note, !note.isEmpty {
                        Text("•")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(note)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
            }

            Spacer()

            if showCopiedFeedback {
                Text("Copied")
                    .font(.caption)
                    .foregroundColor(.green)
                    .transition(.opacity)
            }

            Button(action: {
                onCopy()
                withAnimation {
                    showCopiedFeedback = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        showCopiedFeedback = false
                    }
                }
            }) {
                Image(systemName: "doc.on.doc")
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
            .buttonStyle(.borderless)

            Button(action: onDelete) {
                Image(systemName: "trash")
                    .font(.body)
                    .foregroundColor(.red)
            }
            .buttonStyle(.borderless)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        CaseNumberRow(
            caseNumber: "ABC-123456",
            dateAdded: Date(),
            note: "Chocolate ingestion",
            onCopy: {},
            onDelete: {}
        )
        CaseNumberRow(
            caseNumber: "XYZ-789012",
            dateAdded: Date().addingTimeInterval(-86400 * 7),
            note: nil,
            onCopy: {},
            onDelete: {}
        )
    }
}
