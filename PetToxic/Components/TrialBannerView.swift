import SwiftUI

struct TrialBannerView: View {
    @ObservedObject private var proSettings = ProSettings.shared
    @ObservedObject private var trialManager = TrialManager.shared
    @State private var showUpgradeSheet = false

    var body: some View {
        if !proSettings.hasPurchasedPro {
            Button {
                showUpgradeSheet = true
            } label: {
                bannerContent
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showUpgradeSheet) {
                UpgradeView()
            }
        }
    }

    @ViewBuilder
    private var bannerContent: some View {
        switch trialManager.trialState {
        case .neverStarted:
            bannerRow(
                icon: "gift.fill",
                iconColor: AppColors.teal,
                text: "Try All Pro Features Free for 30 Days",
                borderColor: AppColors.teal
            )

        case .active(let days):
            if days <= 7 {
                bannerRow(
                    icon: "exclamationmark.triangle.fill",
                    iconColor: .orange,
                    text: days == 1 ? "Pro Trial: Last day!" : "Pro Trial: \(days) days remaining",
                    borderColor: .orange
                )
            } else {
                bannerRow(
                    icon: "clock.fill",
                    iconColor: AppColors.teal,
                    text: "Pro Trial: \(days) days remaining",
                    borderColor: AppColors.teal.opacity(0.5)
                )
            }

        case .expired:
            bannerRow(
                icon: "lock.fill",
                iconColor: .red,
                text: "Your Pro trial has ended \u{2014} Upgrade to keep access",
                borderColor: .red.opacity(0.6)
            )
        }
    }

    private func bannerRow(icon: String, iconColor: Color, text: String, borderColor: Color) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(iconColor)

            Text(text)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.white.opacity(0.4))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(borderColor, lineWidth: 1)
                )
        )
    }
}

#Preview {
    ZStack {
        AppBackground()
        VStack(spacing: 16) {
            TrialBannerView()
                .padding(.horizontal)
        }
    }
}
