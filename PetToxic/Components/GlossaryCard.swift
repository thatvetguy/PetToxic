//
//  GlossaryCard.swift
//  PetToxic
//
//  Created by Claude Code on 2/2/26.
//

import SwiftUI

struct GlossaryCard: View {
    @State private var showingGlossary = false

    var body: some View {
        Button {
            showingGlossary = true
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "character.book.closed.fill")
                    .font(.title2)
                    .foregroundColor(.teal)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Medical Glossary")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("Look up veterinary & toxicology terms")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.teal.opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showingGlossary) {
            GlossaryView()
        }
    }
}

#Preview {
    ZStack {
        AppBackground()

        GlossaryCard()
            .padding()
    }
}
