import SwiftUI

struct EmergencyVetButton: View {
    let name: String?
    let phone: String?
    let address: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header
            HStack(spacing: 8) {
                Image(systemName: "cross.case.fill")
                    .foregroundColor(.green)
                    .font(.title3)

                Text(name?.isEmpty == false ? name! : "My Emergency Vet")
                    .font(.headline)
                    .foregroundColor(.white)

                Spacer()
            }

            // Call button
            if let phone = phone, !phone.isEmpty {
                Button {
                    AppTrackingService.recordCall("emergencyvet")
                    let digits = phone.filter { $0.isNumber }
                    if let url = URL(string: "tel://\(digits)") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.green)

                        VStack(alignment: .leading, spacing: 1) {
                            Text("Call")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(phone)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }

                        Spacer()

                        Text("Call")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }
                    .padding(10)
                    .background(Color.green.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }

            // Open in Maps button
            if let address = address, !address.isEmpty {
                Button {
                    if let encoded = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: "http://maps.apple.com/?q=\(encoded)") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack {
                        Image(systemName: "map.fill")
                            .foregroundColor(.blue)

                        VStack(alignment: .leading, spacing: 1) {
                            Text("Address")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(address)
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                        }

                        Spacer()

                        Text("Maps")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                    .padding(10)
                    .background(Color.blue.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.green.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    ZStack {
        AppBackground()
        EmergencyVetButton(
            name: "City Animal ER",
            phone: "(555) 123-4567",
            address: "123 Main St, Anytown, CA 90210"
        )
        .padding()
    }
}
