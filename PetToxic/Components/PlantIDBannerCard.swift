import SwiftUI

/// Banner card linking to the "Poisons Help" Facebook group for emergency plant/mushroom identification.
struct PlantIDBannerCard: View {
    private let groupURL = URL(string: "https://www.facebook.com/groups/144798092849300/")!

    var body: some View {
        Button {
            UIApplication.shared.open(groupURL)
        } label: {
            VStack(spacing: 0) {
                // Group banner image
                Image("poisons_help_banner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 100)
                    .clipped()

                // Text content
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Image(systemName: "leaf.fill")
                            .foregroundColor(.green)
                        Text("Can't identify a plant?")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                    }

                    Text("Get emergency plant & mushroom identification from expert botanists worldwide.")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(2)

                    Text("Facebook group \u{00B7} Free \u{00B7} Account required")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.4))
                }
                .padding(12)
            }
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.green.opacity(0.3), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        AppBackground()
        PlantIDBannerCard()
            .padding()
    }
}
