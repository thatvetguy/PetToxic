import SwiftUI

struct AdBannerPlaceholder: View {
    // TODO: Replace with actual paid user check
    let isPaidUser: Bool = false

    var body: some View {
        Group {
            if isPaidUser {
                // "Did You Know" section for paid users
                DidYouKnowPlaceholder()
            } else {
                // Ad banner placeholder for free users
                VStack {
                    Text("Advertisement")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.5))

                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 50)
                        .overlay(
                            Text("Ad Banner Placeholder")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.3))
                        )
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
    }
}

struct DidYouKnowPlaceholder: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.yellow)
                Text("Did You Know?")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }

            Text("Placeholder for pet safety facts...")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

#Preview {
    ZStack {
        AppBackground()
        VStack {
            Spacer()
            AdBannerPlaceholder()
        }
    }
}
