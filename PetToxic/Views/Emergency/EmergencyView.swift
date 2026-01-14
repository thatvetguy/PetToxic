import SwiftUI

struct EmergencyView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Contact Poison Control")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("If your pet has ingested or been exposed to a potentially toxic substance, call immediately.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }

                    // Call buttons
                    VStack(spacing: 16) {
                        PoisonControlButton(contact: .aspca, style: .large)
                        PoisonControlButton(contact: .petPoisonHelpline, style: .large)
                    }

                    // Fee notice
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.secondary)
                        Text("Consultation fees may apply for both services.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    // What to have ready
                    whatToHaveReadySection
                }
                .padding()
            }
            .navigationTitle("Emergency")
        }
    }

    private var whatToHaveReadySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("What to Have Ready")
                .font(.title2)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: 12) {
                infoRow(icon: "pawprint", text: "Pet's species, breed, weight, and age")
                infoRow(icon: "pills", text: "Name and amount of substance")
                infoRow(icon: "clock", text: "Time of exposure")
                infoRow(icon: "list.bullet.clipboard", text: "Current symptoms observed")
            }
            .padding()
            .background(Color(.secondarySystemBackground))
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
        }
    }
}

#Preview {
    EmergencyView()
}
