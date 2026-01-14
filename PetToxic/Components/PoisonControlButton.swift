import SwiftUI

struct EmergencyContact {
    let name: String
    let phone: String
    let displayPhone: String
    let note: String?

    static let aspca = EmergencyContact(
        name: "ASPCA Animal Poison Control",
        phone: "8884264435",
        displayPhone: "(888) 426-4435",
        note: "Consultation fee may apply"
    )

    static let petPoisonHelpline = EmergencyContact(
        name: "Pet Poison Helpline",
        phone: "8557647661",
        displayPhone: "(855) 764-7661",
        note: "Consultation fee may apply"
    )
}

enum PoisonControlButtonStyle {
    case compact
    case large
}

struct PoisonControlButton: View {
    let contact: EmergencyContact
    var style: PoisonControlButtonStyle = .compact

    var body: some View {
        Button {
            callNumber(contact.phone)
        } label: {
            content
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Call \(contact.name), \(contact.displayPhone)")
        .accessibilityHint("Double tap to call")
    }

    @ViewBuilder
    private var content: some View {
        switch style {
        case .compact:
            compactContent
        case .large:
            largeContent
        }
    }

    private var compactContent: some View {
        HStack {
            Image(systemName: "phone.fill")
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 2) {
                Text(contact.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(contact.displayPhone)
                    .font(.caption)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
        }
        .foregroundStyle(.white)
        .padding()
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var largeContent: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "phone.fill")
                    .font(.title2)
                Text(contact.name)
                    .font(.headline)
                    .fontWeight(.bold)
            }

            Text(contact.displayPhone)
                .font(.title)
                .fontWeight(.bold)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func callNumber(_ number: String) {
        guard let url = URL(string: "tel://\(number)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        PoisonControlButton(contact: .aspca)
        PoisonControlButton(contact: .petPoisonHelpline)
        PoisonControlButton(contact: .aspca, style: .large)
    }
    .padding()
}
