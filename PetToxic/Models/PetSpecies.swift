import Foundation

enum PetSpecies: String, CaseIterable, Codable {
    // Dogs & Cats (always at top)
    case canine
    case feline

    // Small Mammals
    case rabbit
    case ferret
    case guineaPig
    case hamster
    case gerbil
    case chinchilla
    case rat
    case mouse
    case hedgehog
    case sugarGlider
    case otherSmallMammal

    // Birds
    case parakeet
    case cockatiel
    case parrot
    case canary
    case finch
    case lovebird
    case conure
    case cockatoo
    case macaw
    case africanGrey
    case otherBird

    // Reptiles
    case beardedDragon
    case leopardGecko
    case ballPython
    case cornSnake
    case turtle
    case tortoise
    case iguana
    case chameleon
    case blueTonguedSkink
    case otherReptile

    var displayName: String {
        switch self {
        case .canine: return "Canine (Dog)"
        case .feline: return "Feline (Cat)"
        case .guineaPig: return "Guinea Pig"
        case .sugarGlider: return "Sugar Glider"
        case .otherSmallMammal: return "Other Small Mammal"
        case .africanGrey: return "African Grey"
        case .otherBird: return "Other Bird"
        case .beardedDragon: return "Bearded Dragon"
        case .leopardGecko: return "Leopard Gecko"
        case .ballPython: return "Ball Python"
        case .cornSnake: return "Corn Snake"
        case .blueTonguedSkink: return "Blue-Tongued Skink"
        case .otherReptile: return "Other Reptile"
        default:
            // Capitalize first letter for simple names
            return rawValue.prefix(1).uppercased() + rawValue.dropFirst()
        }
    }

    var category: PetSpeciesCategory {
        switch self {
        case .canine, .feline:
            return .dogCat
        case .rabbit, .ferret, .guineaPig, .hamster, .gerbil, .chinchilla, .rat, .mouse, .hedgehog, .sugarGlider, .otherSmallMammal:
            return .smallMammal
        case .parakeet, .cockatiel, .parrot, .canary, .finch, .lovebird, .conure, .cockatoo, .macaw, .africanGrey, .otherBird:
            return .bird
        case .beardedDragon, .leopardGecko, .ballPython, .cornSnake, .turtle, .tortoise, .iguana, .chameleon, .blueTonguedSkink, .otherReptile:
            return .reptile
        }
    }

    // Grouped for picker display - "Other" at end of each category
    static var grouped: [(category: PetSpeciesCategory, species: [PetSpecies])] {
        [
            (.dogCat, [.canine, .feline]),
            (.smallMammal, [.rabbit, .ferret, .guineaPig, .hamster, .gerbil, .chinchilla, .rat, .mouse, .hedgehog, .sugarGlider, .otherSmallMammal]),
            (.bird, [.parakeet, .cockatiel, .parrot, .canary, .finch, .lovebird, .conure, .cockatoo, .macaw, .africanGrey, .otherBird]),
            (.reptile, [.beardedDragon, .leopardGecko, .ballPython, .cornSnake, .turtle, .tortoise, .iguana, .chameleon, .blueTonguedSkink, .otherReptile])
        ]
    }
}

enum PetSpeciesCategory: String, CaseIterable {
    case dogCat = "Dogs & Cats"
    case smallMammal = "Small Mammals"
    case bird = "Birds"
    case reptile = "Reptiles"
}
