import SwiftUI

struct RelatedEntryButton: View {
    let item: ToxicItem

    var body: some View {
        NavigationLink(value: item) {
            HStack {
                Text(item.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(minHeight: 44)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Related entry: \(item.name)")
    }
}

#Preview {
    NavigationStack {
        VStack {
            RelatedEntryButton(item: .sample)
        }
        .padding()
    }
}
