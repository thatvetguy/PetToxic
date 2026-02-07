import Foundation

struct Breed: Codable {
    let name: String
    let aliases: [String]
    var generateMix: Bool?
    var isCrossbreed: Bool?

    var mixName: String {
        "\(name) Mix"
    }
}

class BreedService {
    static let shared = BreedService()

    private var breeds: [String: [Breed]] = [:]

    private init() {
        loadBreeds()
    }

    private func loadBreeds() {
        guard let url = Bundle.main.url(forResource: "breeds", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            #if DEBUG
            print("Failed to load breeds.json")
            #endif
            return
        }

        do {
            breeds = try JSONDecoder().decode([String: [Breed]].self, from: data)
        } catch {
            #if DEBUG
            print("Failed to decode breeds.json: \(error)")
            #endif
        }
    }

    /// Search breeds for a given species with fuzzy matching
    /// - Parameters:
    ///   - query: Search text
    ///   - species: The species to filter by
    /// - Returns: Array of matching breed names (including mixes)
    func searchBreeds(query: String, for species: PetSpecies) -> [String] {
        let speciesKey = species.rawValue
        guard let speciesBreeds = breeds[speciesKey] else { return [] }

        let lowercasedQuery = query.lowercased().trimmingCharacters(in: .whitespaces)

        if lowercasedQuery.isEmpty {
            // Return all breeds for this species (limited to first 20)
            return speciesBreeds.prefix(20).flatMap { breed -> [String] in
                if breed.generateMix == true {
                    return [breed.name, breed.mixName]
                }
                return [breed.name]
            }
        }

        var results: [(breed: Breed, score: Int)] = []

        for breed in speciesBreeds {
            var score = 0

            // Check breed name
            let breedNameLower = breed.name.lowercased()
            if breedNameLower == lowercasedQuery {
                score = 100 // Exact match
            } else if breedNameLower.hasPrefix(lowercasedQuery) {
                score = 80 // Prefix match
            } else if breedNameLower.contains(lowercasedQuery) {
                score = 60 // Contains match
            }

            // Check aliases
            for alias in breed.aliases {
                let aliasLower = alias.lowercased()
                if aliasLower == lowercasedQuery {
                    score = max(score, 95) // Exact alias match
                } else if aliasLower.hasPrefix(lowercasedQuery) {
                    score = max(score, 75) // Alias prefix match
                } else if aliasLower.contains(lowercasedQuery) {
                    score = max(score, 55) // Alias contains match
                }
            }

            if score > 0 {
                results.append((breed, score))
            }
        }

        // Sort by score (highest first), then by name
        results.sort {
            if $0.score != $1.score {
                return $0.score > $1.score
            }
            return $0.breed.name < $1.breed.name
        }

        // Build result array with mixes
        var output: [String] = []
        for (breed, _) in results.prefix(10) {
            output.append(breed.name)
            if breed.generateMix == true {
                output.append(breed.mixName)
            }
        }

        return output
    }

    /// Get all breeds for a species (for picker fallback)
    func allBreeds(for species: PetSpecies) -> [String] {
        let speciesKey = species.rawValue
        guard let speciesBreeds = breeds[speciesKey] else { return [] }

        return speciesBreeds.flatMap { breed -> [String] in
            if breed.generateMix == true {
                return [breed.name, breed.mixName]
            }
            return [breed.name]
        }
    }
}
