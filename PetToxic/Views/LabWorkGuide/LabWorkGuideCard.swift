//
//  LabWorkGuideCard.swift
//  PetToxic
//
//  Created by Claude Code on 2/5/26.
//

import SwiftUI

struct LabWorkGuideCard: View {
    @ObservedObject private var proSettings = ProSettings.shared
    @State private var showLabWorkGuide = false
    @State private var showProUpsell = false
    @State private var showUpgradeSheet = false

    private var isProUnlocked: Bool { proSettings.isPro }


    var body: some View {
        Button {
            if isProUnlocked {
                showLabWorkGuide = true
            } else {
                showProUpsell = true
            }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "cross.vial.fill")
                    .font(.title2)
                    .foregroundColor(isProUnlocked ? .teal : .white.opacity(0.3))

                VStack(alignment: .leading, spacing: 2) {
                    Text("Lab Work Guide")
                        .font(.headline)
                        .foregroundColor(isProUnlocked ? .white : .white.opacity(0.6))

                    Text("Understand your pet's blood work")
                        .font(.caption)
                        .foregroundColor(isProUnlocked ? .white.opacity(0.7) : .white.opacity(0.4))
                }

                Spacer()

                if isProUnlocked {
                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.5))
                } else {
                    HStack(spacing: 8) {
                        Text("PRO")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(AppColors.teal.opacity(0.8))
                            .clipShape(Capsule())

                        Image(systemName: "lock.fill")
                            .foregroundColor(.white.opacity(0.3))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(isProUnlocked ? 0.1 : 0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isProUnlocked ? Color.teal.opacity(0.3) : Color.white.opacity(0.1), lineWidth: 1)
                    )
            )
            .opacity(isProUnlocked ? 1.0 : 0.6)
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showLabWorkGuide) {
            LabWorkGuideView()
        }
        .alert("Pro Feature", isPresented: $showProUpsell) {
            Button("Not Now", role: .cancel) { }
            if TrialManager.shared.hasNeverTrialed {
                Button("Try Free Trial") {
                    TrialManager.shared.startTrial()
                }
            }
            Button("Upgrade to Pro") { showUpgradeSheet = true }
        } message: {
            Text("Understand your pet's blood work results. Upgrade to Pro to access the Lab Work Guide."
                + (TrialManager.shared.hasNeverTrialed
                   ? "\n\nOr start a free 30-day trial." : ""))
        }
        .sheet(isPresented: $showUpgradeSheet) {
            UpgradeView()
        }
    }
}

#Preview {
    ZStack {
        AppBackground()

        VStack(spacing: 16) {
            LabWorkGuideCard()
                .padding()
        }
    }
}
