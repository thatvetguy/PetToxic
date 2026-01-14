import SwiftUI

struct SpeciesFilterView: View {
    @Binding var selectedSpecies: Set<Species>

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                // All filter
                FilterChip(
                    title: "All",
                    icon: "pawprint.fill",
                    isSelected: selectedSpecies.isEmpty
                ) {
                    selectedSpecies.removeAll()
                }

                // Species filters
                ForEach(Species.allCases) { species in
                    FilterChip(
                        title: species.displayName,
                        icon: species.icon,
                        isSelected: selectedSpecies.contains(species)
                    ) {
                        if selectedSpecies.contains(species) {
                            selectedSpecies.remove(species)
                        } else {
                            selectedSpecies.insert(species)
                        }
                    }
                }
            }
        }
    }
}

struct FilterChip: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                Text(title)
                    .font(.subheadline)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color("AccentColor") : Color(.systemGray5))
            .foregroundStyle(isSelected ? .white : .primary)
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    SpeciesFilterView(selectedSpecies: .constant([.dog]))
        .padding()
}
