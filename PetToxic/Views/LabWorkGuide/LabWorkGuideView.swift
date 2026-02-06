//
//  LabWorkGuideView.swift
//  PetToxic
//
//  Created by Claude Code on 2/5/26.
//

import SwiftUI

struct LabWorkGuideView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var viewMode: ViewMode = .category
    @State private var expandedCategories: Set<LabCategory> = []
    @State private var isDisclaimerExpanded = false
    @State private var showSources = false

    private let service = LabWorkGuideService.shared

    enum ViewMode: String, CaseIterable {
        case category = "By Category"
        case alphabetical = "A-Z"
    }

    // MARK: - Computed Properties

    private var searchResults: [LabParameter] {
        service.search(query: searchText)
    }

    private var orderedCategories: [LabCategory] {
        var result: [LabCategory] = []
        for panelType in LabPanelType.allCases {
            result.append(contentsOf: service.populatedCategories(for: panelType))
        }
        return result
    }

    // MARK: - Body

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

                VStack(spacing: 0) {
                    // 1. Disclaimer bar
                    disclaimerBar
                        .padding(.horizontal)
                        .padding(.top, 8)

                    // 2. Search bar
                    searchBar
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .padding(.bottom, 8)

                    // 3. Segmented control (hidden during search)
                    if searchText.isEmpty {
                        viewModePicker
                            .padding(.horizontal)
                            .padding(.bottom, 12)
                    }

                    // 4. Content
                    if searchResults.isEmpty && !searchText.isEmpty {
                        emptyStateView
                    } else if !searchText.isEmpty {
                        searchResultsList
                    } else if viewMode == .category {
                        categoryList
                    } else {
                        alphabeticalList
                    }
                }
            }
            .navigationTitle("Lab Work Guide")
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
            .sheet(isPresented: $showSources) {
                LabWorkGuideSourcesView()
            }
        }
    }

    // MARK: - Disclaimer Bar

    private var disclaimerBar: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isDisclaimerExpanded.toggle()
                }
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.orange)
                        .font(.subheadline)

                    Text("For educational purposes only. Not a diagnostic tool.")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.8))
                        .lineLimit(1)

                    Spacer()

                    Text("Full disclaimer")
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.5))

                    Image(systemName: isDisclaimerExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
            }
            .buttonStyle(.plain)

            if isDisclaimerExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Text("This information is for educational purposes only and is not a substitute for professional veterinary interpretation of laboratory results. Lab values must be interpreted in the context of your pet's overall health, history, and physical examination.")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.9))

                    Text("Always discuss your pet's lab results with your veterinarian. Do not attempt to diagnose or treat based on this guide alone.")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.orange.opacity(0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    // MARK: - Search Bar

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white.opacity(0.6))

            TextField("Search parameters...", text: $searchText)
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

    // MARK: - View Mode Picker

    private var viewModePicker: some View {
        Picker("View Mode", selection: $viewMode) {
            ForEach(ViewMode.allCases, id: \.self) { mode in
                Text(mode.rawValue).tag(mode)
            }
        }
        .pickerStyle(.segmented)
    }

    // MARK: - Category List

    private var categoryList: some View {
        ScrollView {
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                ForEach(orderedCategories, id: \.self) { category in
                    Section {
                        if expandedCategories.contains(category) {
                            ForEach(service.parameters(for: category)) { param in
                                NavigationLink(destination: LabParameterDetailView(parameter: param)) {
                                    ParameterRowView(parameter: param)
                                }
                            }
                        }
                    } header: {
                        categoryHeader(for: category)
                    }
                }
            }
            .padding(.horizontal)

            sourcesButton
                .padding(.top, 16)
                .padding(.bottom, 24)
                .padding(.horizontal)
        }
        .scrollDismissesKeyboard(.interactively)
    }

    // MARK: - Category Header

    private func categoryHeader(for category: LabCategory) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.25)) {
                if expandedCategories.contains(category) {
                    expandedCategories.remove(category)
                } else {
                    expandedCategories.insert(category)
                }
            }
        } label: {
            HStack(spacing: 10) {
                // Category icon
                Image(systemName: category.icon)
                    .font(.subheadline)
                    .foregroundColor(.teal)
                    .frame(width: 24)

                // Category name
                Text(category.displayName)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Spacer()

                // Panel badge
                Text(category.panelType.displayName)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.15))
                    )

                // Parameter count
                Text("\(service.parameters(for: category).count)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))

                // Expand/collapse chevron
                Image(systemName: expandedCategories.contains(category) ? "chevron.down" : "chevron.right")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 4)
            .background(Color(red: 0.0, green: 0.22, blue: 0.32))
        }
        .buttonStyle(.plain)
    }

    // MARK: - Alphabetical List

    private var alphabeticalList: some View {
        ScrollView {
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                ForEach(service.parametersByLetter(), id: \.letter) { group in
                    Section {
                        ForEach(group.parameters) { param in
                            NavigationLink(destination: LabParameterDetailView(parameter: param)) {
                                ParameterRowView(parameter: param)
                            }
                        }
                    } header: {
                        HStack {
                            Text(group.letter)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                        .background(Color(red: 0.0, green: 0.22, blue: 0.32))
                    }
                }
            }
            .padding(.horizontal)

            sourcesButton
                .padding(.top, 16)
                .padding(.bottom, 24)
                .padding(.horizontal)
        }
        .scrollDismissesKeyboard(.interactively)
    }

    // MARK: - Search Results List

    private var searchResultsList: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(searchResults) { param in
                    NavigationLink(destination: LabParameterDetailView(parameter: param)) {
                        ParameterRowView(parameter: param)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .scrollDismissesKeyboard(.interactively)
    }

    // MARK: - Empty State

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "text.magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.white.opacity(0.4))

            Text("No parameters found")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))

            Text("Try a different search term")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.5))

            Spacer()
        }
    }

    // MARK: - Sources Button

    private var sourcesButton: some View {
        Button {
            showSources = true
        } label: {
            HStack {
                Image(systemName: "book.closed.fill")
                    .font(.subheadline)
                    .foregroundColor(.teal)

                Text("Sources")
                    .font(.subheadline)
                    .foregroundColor(.teal)

                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.teal.opacity(0.6))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.white.opacity(0.08))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.teal.opacity(0.2), lineWidth: 1)
            )
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Parameter Row View

private struct ParameterRowView: View {
    let parameter: LabParameter

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 0) {
                    Text(parameter.abbreviation)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text(" – ")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.6))

                    Text(parameter.name)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(1)
                }
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
    LabWorkGuideView()
}
