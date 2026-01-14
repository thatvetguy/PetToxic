import SwiftUI

/// Custom empty state view compatible with iOS 16+
/// Mimics the iOS 17 ContentUnavailableView API
struct EmptyStateView: View {
    let title: String
    let systemImage: String
    let description: String?

    init(_ title: String, systemImage: String, description: Text? = nil) {
        self.title = title
        self.systemImage = systemImage
        self.description = description.map { String("\($0)") }
    }

    init(_ title: String, systemImage: String, description: String) {
        self.title = title
        self.systemImage = systemImage
        self.description = description
    }

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: systemImage)
                .font(.system(size: 48))
                .foregroundStyle(.secondary)

            Text(title)
                .font(.title2)
                .fontWeight(.semibold)

            if let description = description {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(
        "No Results",
        systemImage: "magnifyingglass",
        description: "Try searching for something else."
    )
}
