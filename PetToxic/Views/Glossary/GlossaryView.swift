//
//  GlossaryView.swift
//  PetToxic
//
//  Created by Claude Code on 2/2/26.
//

import SwiftUI

struct GlossaryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""

    private let glossaryService = GlossaryService.shared

    // MARK: - Computed Properties

    private var filteredTerms: [GlossaryTerm] {
        if searchText.isEmpty {
            return glossaryService.sortedTerms
        } else {
            return glossaryService.search(searchText)
        }
    }

    private var groupedTerms: [String: [GlossaryTerm]] {
        Dictionary(grouping: filteredTerms) { term in
            String(term.term.prefix(1)).uppercased()
        }
    }

    private var availableLetters: [String] {
        groupedTerms.keys.sorted()
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient (consistent with app)
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

                VStack(spacing: 0) {
                    // Search bar
                    searchBar
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .padding(.bottom, 12)

                    // Terms list
                    if filteredTerms.isEmpty {
                        emptyStateView
                    } else {
                        termsList
                    }
                }
            }
            .navigationTitle("Glossary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(red: 0.0, green: 0.25, blue: 0.35), for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                }
            }
        }
    }

    // MARK: - Search Bar

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white.opacity(0.6))

            TextField("Search terms...", text: $searchText)
                .foregroundColor(.white)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white.opacity(0.6))
                }
            }
        }
        .padding(12)
        .background(Color.white.opacity(0.15))
        .cornerRadius(10)
    }

    // MARK: - Terms List

    private var termsList: some View {
        ScrollView {
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                ForEach(availableLetters, id: \.self) { letter in
                    Section {
                        ForEach(groupedTerms[letter] ?? []) { term in
                            NavigationLink(destination: GlossaryTermDetailView(term: term)) {
                                TermRowView(term: term)
                            }
                        }
                    } header: {
                        sectionHeader(for: letter)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .scrollDismissesKeyboard(.interactively)
    }

    // MARK: - Section Header

    private func sectionHeader(for letter: String) -> some View {
        HStack {
            Text(letter)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
        .background(Color(red: 0.0, green: 0.22, blue: 0.32))
    }

    // MARK: - Empty State

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "text.magnifyingglass")
                .font(.largeTitle)
                .foregroundColor(.white.opacity(0.4))

            Text("No terms found")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))

            Text("Try a different search term")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.5))

            Spacer()
        }
    }
}

// MARK: - Term Row View

private struct TermRowView: View {
    let term: GlossaryTerm

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(term.term)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(term.definition.trimmingCharacters(in: .whitespacesAndNewlines))
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(2)
                    .truncationMode(.tail)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
        .contentShape(Rectangle())
    }
}

// MARK: - Preview

#Preview {
    GlossaryView()
}
