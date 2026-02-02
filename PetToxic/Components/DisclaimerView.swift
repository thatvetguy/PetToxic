import SwiftUI

struct DisclaimerView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.orange)
                Text("DISCLAIMER")
                    .font(.headline)
                    .fontWeight(.bold)
            }

            Text("This information is for educational purposes only and does not constitute veterinary medical advice. If your pet has been exposed to a potentially toxic substance, contact a licensed veterinarian or animal poison control center immediately.")
                .font(.subheadline)
                .foregroundStyle(.primary)

            Text("This database covers common toxic substances but is not a comprehensive listing of all possible hazards. The absence of a substance from this app should not be interpreted as an indication of safety. When in doubt, contact a veterinarian or animal poison control center.")
                .font(.subheadline)
                .foregroundStyle(.primary)

            Text("Images are AI-generated for illustration only and should not be used to identify real-world plants, substances, or products. Any resemblance to specific commercial brands is coincidental and unintentional.")
                .font(.subheadline)
                .foregroundStyle(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow.opacity(0.2))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.yellow.opacity(0.5), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    DisclaimerView()
        .padding()
}
