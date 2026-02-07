import SwiftUI

struct DisclaimerPopupView: View {
    @AppStorage("disclaimerAcknowledgedVersion") private var acknowledgedVersion: String = ""
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.102, green: 0.227, blue: 0.227),
                    Color(red: 0.051, green: 0.122, blue: 0.122)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)

                Text("Important Information")
                    .font(.title2)
                    .fontWeight(.bold)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("This information is for educational purposes only and does not constitute veterinary medical advice. If your pet has been exposed to a potentially toxic substance, contact a licensed veterinarian or animal poison control center immediately.")
                            .font(.subheadline)

                        Text("This database covers common toxic substances but is not a comprehensive listing of all possible hazards. The absence of a substance from this app should not be interpreted as an indication of safety. When in doubt, contact a veterinarian or animal poison control center.")
                            .font(.subheadline)

                        Text("Images are AI-generated for illustration only and should not be used to identify real-world plants, substances, or products. Any resemblance to specific commercial brands is coincidental and unintentional.")
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                }

                Button(action: {
                    let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"
                    acknowledgedVersion = currentVersion
                    isPresented = false
                }) {
                    Text("I Understand")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color("AccentColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.vertical, 40)
        }
        .interactiveDismissDisabled()
    }
}

#Preview {
    DisclaimerPopupView(isPresented: .constant(true))
}
