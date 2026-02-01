import SwiftUI

struct EmergencyView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Pet info card (PRO feature)
                        EmergencyPetInfoCard()

                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contact Poison Control")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text("If your pet has ingested or been exposed to a potentially toxic substance, call immediately.")
                                .font(.body)
                                .foregroundStyle(.white.opacity(0.7))
                        }

                        // Call buttons
                        VStack(spacing: 16) {
                            PoisonControlButton(contact: .aspca, style: .large)
                            PoisonControlButton(contact: .petPoisonHelpline, style: .large)
                        }

                        Text("Pet Toxic is not affiliated with these organizations.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.top, -8)

                        // Fee notice
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundStyle(.white.opacity(0.6))
                            Text("Consultation fees may apply for both services.")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.6))
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                        // What to have ready
                        whatToHaveReadySection
                    }
                    .padding()
                    .padding(.bottom, 80) // Extra space for tab bar
                }
            }
            .navigationTitle("Emergency")
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }

    private var whatToHaveReadySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("What to Have Ready")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 12) {
                infoRow(icon: "pawprint", text: "Pet's species, breed, weight, and age")
                infoRow(icon: "pills", text: "Name and amount of substance")
                infoRow(icon: "clock", text: "Time of exposure")
                infoRow(icon: "list.bullet.clipboard", text: "Current symptoms observed")
            }
            .padding()
            .background(Color.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private func infoRow(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(Color("AccentColor"))
                .frame(width: 24)

            Text(text)
                .font(.body)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    EmergencyView()
}
