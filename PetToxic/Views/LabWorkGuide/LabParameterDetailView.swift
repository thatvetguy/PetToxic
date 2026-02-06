//
//  LabParameterDetailView.swift
//  PetToxic
//
//  Created by Claude Code on 2/5/26.
//

import SwiftUI

struct LabParameterDetailView: View {
    let parameter: LabParameter

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.0, green: 0.25, blue: 0.35),
                    Color(red: 0.0, green: 0.20, blue: 0.30),
                    Color(red: 0.0, green: 0.15, blue: 0.25)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // 1. Header
                    headerSection

                    Divider()
                        .background(Color.white.opacity(0.3))

                    // 2. What It Measures
                    contentSection(
                        title: "What It Measures",
                        content: parameter.whatItMeasures,
                        accentColor: .teal
                    )

                    // 3. What HIGH May Mean
                    contentSection(
                        title: "What HIGH May Mean",
                        content: parameter.highMeaning,
                        accentColor: .orange
                    )

                    // 4. What LOW May Mean (conditional)
                    if let lowMeaning = parameter.lowMeaning {
                        contentSection(
                            title: "What LOW May Mean",
                            content: lowMeaning,
                            accentColor: .blue
                        )
                    }

                    // 5. Species Notes (conditional)
                    if let speciesNotes = parameter.speciesNotes {
                        contentSection(
                            title: "Species Notes",
                            content: speciesNotes,
                            accentColor: .teal
                        )
                    }

                    Divider()
                        .background(Color.white.opacity(0.3))

                    // 6. Footer
                    footerSection

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
        }
        .navigationTitle(parameter.abbreviation)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(red: 0.0, green: 0.25, blue: 0.35), for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    // MARK: - Header Section

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Full name
            Text(parameter.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            // Abbreviation
            Text(parameter.abbreviation)
                .font(.title2)
                .foregroundColor(.teal)

            // Alternate abbreviations (if any)
            if let alternates = parameter.alternateAbbreviations, !alternates.isEmpty {
                Text("Also known as: \(alternates.joined(separator: ", "))")
                    .font(.subheadline)
                    .italic()
                    .foregroundColor(.white.opacity(0.7))
            }

            // Panel + Category badges
            HStack(spacing: 8) {
                // Panel badge
                badgeView(
                    text: parameter.panelType.displayName,
                    icon: nil
                )

                // Category badge
                badgeView(
                    text: parameter.category.displayName,
                    icon: parameter.category.icon
                )
            }
            .padding(.top, 4)
        }
    }

    // MARK: - Badge View

    private func badgeView(text: String, icon: String?) -> some View {
        HStack(spacing: 4) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.caption2)
            }
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
        }
        .foregroundColor(.white.opacity(0.8))
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill(Color.white.opacity(0.15))
        )
    }

    // MARK: - Content Section

    private func contentSection(title: String, content: String, accentColor: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(accentColor)

            Text(content)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    // MARK: - Footer Section

    private var footerSection: some View {
        HStack {
            Spacer()
            Text("Always discuss your pet's lab results with your veterinarian.")
                .font(.footnote)
                .italic()
                .foregroundColor(.white.opacity(0.6))
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding(.top, 8)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        LabParameterDetailView(parameter: LabWorkGuideService.shared.allParametersAlphabetical().first!)
    }
}
