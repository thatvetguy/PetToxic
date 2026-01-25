import SwiftUI

struct MyPetsPlaceholder: View {
    @ObservedObject private var proSettings = ProSettings.shared

    private var isPaidUser: Bool { proSettings.isPro }

    var body: some View {
        VStack(spacing: 12) {
            // Section header
            HStack {
                Image(systemName: "pawprint.fill")
                    .foregroundColor(Color(red: 0.29, green: 0.61, blue: 0.61)) // #4A9B9B
                Text("My Pets")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()

                // Pro badge
                if !isPaidUser {
                    Text("PRO")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(red: 0.29, green: 0.61, blue: 0.61).opacity(0.8))
                        .clipShape(Capsule())
                }
            }

            // Placeholder content
            HStack(spacing: 16) {
                // Pet silhouette placeholder
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 60, height: 60)

                    Image(systemName: "dog.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white.opacity(0.3))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Add your pets")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(isPaidUser ? 1.0 : 0.5))

                    Text("Quick access to pet info during emergencies")
                        .font(.caption)
                        .foregroundColor(.white.opacity(isPaidUser ? 0.7 : 0.4))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(isPaidUser ? 0.5 : 0.3))
            }
            .padding()
            .background(Color.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
        }
        .padding(.horizontal)
        .opacity(isPaidUser ? 1.0 : 0.6) // Grayed out for free users
    }
}

#Preview {
    ZStack {
        AppBackground()
        MyPetsPlaceholder()
    }
}
