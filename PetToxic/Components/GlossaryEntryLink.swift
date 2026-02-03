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
            Button("Maybe Later", role: .cancel) { }
            Button("Learn More") {
                // TODO: Navigate to subscription/upgrade screen
            }
        } message: {
            Text("The Medical Glossary is a Pro feature that helps you understand veterinary terminology. Upgrade to Pro to unlock it.")
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
