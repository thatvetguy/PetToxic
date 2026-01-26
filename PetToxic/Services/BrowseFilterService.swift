import Foundation

class BrowseFilterService {

    /// Get the species that should be shown by default in Browse
    /// Returns nil if no filter should be applied (show all)
    static func getDefaultSpeciesFilter(pets: [Pet]) -> Set<Species>? {
        let prioritizedPets = pets.filter { $0.prioritizeInBrowse }

        if prioritizedPets.isEmpty {
            return nil // No filter, show all
        }

        let species = Set(prioritizedPets.compactMap { petSpeciesToToxicSpecies($0.speciesEnum) })

        if species.isEmpty {
            return nil
        }

        return species
    }

    /// Convert PetSpecies to the Species enum used in ToxicItem
    static func petSpeciesToToxicSpecies(_ petSpecies: PetSpecies) -> Species? {
        switch petSpecies {
        case .canine:
            return .dog
        case .feline:
            return .cat
        case .rabbit, .guineaPig, .hamster, .gerbil, .mouse, .rat, .ferret, .chinchilla, .hedgehog, .sugarGlider, .otherSmallMammal:
            return .smallMammal
        case .parakeet, .cockatiel, .parrot, .canary, .finch, .lovebird, .conure, .macaw, .cockatoo, .africanGrey, .otherBird:
            return .bird
        case .beardedDragon, .leopardGecko, .ballPython, .cornSnake, .turtle, .tortoise, .iguana, .chameleon, .blueTonguedSkink, .otherReptile:
            return .reptile
        }
    }

    /// Check if an entry should be shown for the given species filter
    static func entryMatchesFilter(entry: ToxicItem, speciesFilter: Set<Species>?) -> Bool {
        // No filter = show all
        guard let filter = speciesFilter else {
            return true
        }

        // Informational entries (no species risks) - always show
        if entry.speciesRisks.isEmpty {
            return true
        }

        // Check if entry has ANY of the filtered species
        let entrySpecies = Set(entry.speciesRisks.map { $0.species })

        // Show if there's overlap
        if !entrySpecies.isDisjoint(with: filter) {
            return true
        }

        // Entry explicitly lists species but none match our filter
        // For safety: if our species is NOT listed in entry's risks,
        // it means it's unknown = potentially dangerous = include it
        for species in filter {
            if !entrySpecies.contains(species) {
                return true
            }
        }

        return false
    }
}
