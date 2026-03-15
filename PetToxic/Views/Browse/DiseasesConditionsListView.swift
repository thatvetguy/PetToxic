import SwiftUI

struct DiseasesConditionsListView: View {
    @Binding var navigationPath: NavigationPath
    @Environment(BrowseNavigationContext.self) private var navContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("gridColumnCount") private var columnCount: Int = 2
    @AppStorage("entryViewMode") private var isGridView: Bool = true

    @State private var selectedSpecies: Species? = nil

    private let diseaseService = DiseasesConditionsService.shared

    /// Species display order
    private let speciesOrder: [Species] = [.dog, .cat, .smallMammal, .bird, .reptile]

    /// Ordered species list: selected species first, then the rest
    private var orderedSpecies: [Species] {
        guard let selected = selectedSpecies else { return speciesOrder }
        return [selected] + speciesOrder.filter { $0 != selected }
    }

    /// Sections: each species that has at least one entry
    /// Sort order: infectious diseases first (alphabetically), then conditions (alphabetically)
    private var sections: [(species: Species, items: [ToxicItem])] {
        orderedSpecies.compactMap { species in
            let items = diseaseService.entries(for: species).sorted {
                let lhsInfectious = diseaseService.isInfectious($0)
                let rhsInfectious = diseaseService.isInfectious($1)
                if lhsInfectious != rhsInfectious {
                    return lhsInfectious
                }
                return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
            return items.isEmpty ? nil : (species: species, items: items)
        }
    }

    /// Flattened, deduplicated entry list matching display order for left/right navigation
    private var flattenedEntries: [ToxicItem] {
        var seen = Set<UUID>()
        return sections.flatMap { $0.items }.filter { seen.insert($0.id).inserted }
    }

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 8), count: columnCount)
    }

    var body: some View {
        ZStack {
            AppBackground()

            ScrollView {
                VStack(spacing: 0) {
                    // Species selector chips
                    speciesChips

                    // Grouped disease list
                    ForEach(sections, id: \.species) { section in
                        VStack(alignment: .leading, spacing: 8) {
                            // Section header
                            HStack(spacing: 8) {
                                Image(systemName: section.species.icon)
                                    .foregroundColor(AppColors.teal)
                                Text(section.species.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("(\(section.items.count))")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 16)

                            if isGridView {
                                LazyVGrid(columns: columns, spacing: 8) {
                                    ForEach(section.items) { item in
                                        NavigationLink(value: CategoryEntry(item: item, sourceCategory: .diseasesAndConditions)) {
                                            diseaseGridCard(item: item)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                .padding(.horizontal, 16)
                            } else {
                                LazyVStack(spacing: 4) {
                                    ForEach(section.items) { item in
                                        NavigationLink(value: CategoryEntry(item: item, sourceCategory: .diseasesAndConditions)) {
                                            diseaseListRow(item: item, species: section.species)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                        }
                    }

                    Spacer(minLength: AppLayout.tabBarBottomPadding)
                }
            }
        }
        .navigationTitle("Diseases & Conditions")
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Browse")
                    }
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                if isGridView {
                    Button {
                        cycleGridSize()
                    } label: {
                        Image(systemName: gridIcon)
                    }
                }

                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isGridView.toggle()
                    }
                } label: {
                    Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                }
            }
        }
        .onAppear {
            navContext.enterCategoryList(category: .diseasesAndConditions, entries: flattenedEntries)
        }
        .onChange(of: selectedSpecies) { _, _ in
            navContext.updateVisibleEntries(flattenedEntries)
        }
    }

    // MARK: - Species Chips

    private var speciesChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                chipButton(title: "All", icon: nil, isSelected: selectedSpecies == nil) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedSpecies = nil
                    }
                }
                ForEach(speciesOrder, id: \.self) { species in
                    chipButton(
                        title: species.displayName,
                        icon: species.icon,
                        isSelected: selectedSpecies == species
                    ) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedSpecies = (selectedSpecies == species) ? nil : species
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
    }

    @ViewBuilder
    private func chipButton(title: String, icon: String?, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 4) {
                if let icon {
                    Image(systemName: icon)
                        .font(.caption)
                }
                Text(title)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(isSelected ? Color.teal : Color.white.opacity(0.1))
            .foregroundColor(isSelected ? .white : .gray)
            .cornerRadius(16)
        }
    }

    // MARK: - Disease Grid Card

    @ViewBuilder
    private func diseaseGridCard(item: ToxicItem) -> some View {
        if let imageAsset = item.imageAsset {
            Image(imageAsset)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        } else {
            VStack(spacing: 8) {
                Image(systemName: "microbe")
                    .font(.title)
                    .foregroundColor(AppColors.teal)
                Text(item.name)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background(Color.teal.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.teal.opacity(0.2), lineWidth: 1)
            )
        }
    }

    // MARK: - Disease List Row

    private func diseaseListRow(item: ToxicItem, species: Species) -> some View {
        HStack(spacing: 12) {
            if let imageAsset = item.imageAsset {
                Image(imageAsset)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Image(systemName: "microbe")
                    .font(.title2)
                    .foregroundColor(AppColors.teal)
                    .frame(width: 50, height: 50)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(2)
            }

            Spacer()

            if let risk = item.speciesRisks.first(where: { $0.species == species }) {
                SeverityBadge(severity: risk.severity, size: .small)
            } else if let severity = item.entrySeverity {
                SeverityBadge(severity: severity, size: .small)
            }

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.3))
                .font(.caption)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    // MARK: - Helpers

    private func cycleGridSize() {
        switch columnCount {
        case 1: columnCount = 2
        case 2: columnCount = 3
        case 3: columnCount = 1
        default: columnCount = 2
        }
    }

    private var gridIcon: String {
        switch columnCount {
        case 1: return "rectangle.grid.1x2"
        case 2: return "square.grid.2x2"
        case 3: return "square.grid.3x3"
        default: return "square.grid.2x2"
        }
    }
}
