//
//  GlossaryEntryLink.swift
//  PetToxic
//
//  Created by Claude Code on 2/2/26.
//

import SwiftUI

struct GlossaryEntryLink: View {
    @ObservedObject private var proSettings = ProSettings.shared

    @State private var showingGlossary = false
    @State private var showingUpgradePrompt = false
    @State private var showUpgradeSheet = false

    var body: some View {
        Button {
            if proSettings.isPro {
                showingGlossary = true
            } else {
                showingUpgradePrompt = true
            }
        } label: {
            HStack(spacing: 8) {
                Image(systemName: proSettings.isPro ? "character.book.closed.fill" : "lock.fill")
                    .font(.subheadline)
                    .foregroundColor(.teal)

                Text(proSettings.isPro ? "Medical Glossary" : "Medical Glossary (Pro)")
                    .font(.subheadline)
                    .foregroundColor(.teal)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.teal.opacity(0.7))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.teal.opacity(0.1))
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showingGlossary) {
            GlossaryView()
        }
        .alert("Pro Feature", isPresented: $showingUpgradePrompt) {
            Button("Not Now", role: .cancel) { }
            if TrialManager.shared.hasNeverTrialed {
                Button("Try Free Trial") {
                    TrialManager.shared.startTrial()
                }
            }
            Button("Upgrade to Pro") { showUpgradeSheet = true }
        } message: {
            Text("The Medical Glossary is a Pro feature that helps you understand veterinary terminology. Upgrade to Pro to unlock it."
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

        GlossaryEntryLink()
            .padding()
    }
}
