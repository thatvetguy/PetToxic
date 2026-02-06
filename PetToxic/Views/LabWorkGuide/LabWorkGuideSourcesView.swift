//
//  LabWorkGuideSourcesView.swift
//  PetToxic
//
//  Created by Claude Code on 2/5/26.
//

import SwiftUI

struct LabWorkGuideSourcesView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
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
                    VStack(alignment: .leading, spacing: 16) {
                        Text("The information in the Lab Work Guide is compiled from the following sources:")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.bottom, 8)

                        sourceRow(
                            name: "Merck Veterinary Manual",
                            detail: "merckvetmanual.com"
                        )

                        sourceRow(
                            name: "IDEXX Learning Center",
                            detail: "idexx.com/learning-center"
                        )

                        sourceRow(
                            name: "Cornell University College of Veterinary Medicine — eClinPath",
                            detail: "eclinpath.com"
                        )

                        sourceRow(
                            name: "Veterinary Partner (VIN)",
                            detail: "veterinarypartner.vin.com"
                        )

                        sourceRow(
                            name: "VCA Animal Hospitals",
                            detail: "vcahospitals.com"
                        )

                        sourceRow(
                            name: "Small Animal Clinical Diagnosis by Laboratory Methods",
                            detail: "Willard MD, Tvedten H",
                            isTextbook: true
                        )

                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Sources")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(red: 0.0, green: 0.25, blue: 0.35), for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.teal)
                }
            }
        }
    }

    private func sourceRow(name: String, detail: String, isTextbook: Bool = false) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: isTextbook ? "text.book.closed.fill" : "globe")
                .font(.subheadline)
                .foregroundColor(.teal)
                .frame(width: 24)
                .padding(.top, 2)

            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)

                Text(detail)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .italic(isTextbook)
            }

            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(Color.white.opacity(0.06))
        .cornerRadius(8)
    }
}

#Preview {
    LabWorkGuideSourcesView()
}
