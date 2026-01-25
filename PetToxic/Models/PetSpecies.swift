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

    var displayName: String {
        switch self {
        case .canine: return "Canine (Dog)"
        case .feline: return "Feline (Cat)"
        case .guineaPig: return "Guinea Pig"
        case .sugarGlider: return "Sugar Glider"
        case .africanGrey: return "African Grey"
        case .beardedDragon: return "Bearded Dragon"
        case .leopardGecko: return "Leopard Gecko"
        case .ballPython: return "Ball Python"
        case .cornSnake: return "Corn Snake"
        case .blueTonguedSkink: return "Blue-Tongued Skink"
        default:
            // Capitalize first letter for simple names
            return rawValue.prefix(1).uppercased() + rawValue.dropFirst()
        }
    }

    var category: PetSpeciesCategory {
        switch self {
        case .canine, .feline:
            return .dogCat
        case .rabbit, .ferret, .guineaPig, .hamster, .gerbil, .chinchilla, .rat, .mouse, .hedgehog, .sugarGlider:
            return .smallMammal
        case .parakeet, .cockatiel, .parrot, .canary, .finch, .lovebird, .conure, .cockatoo, .macaw, .africanGrey:
            return .bird
        case .beardedDragon, .leopardGecko, .ballPython, .cornSnake, .turtle, .tortoise, .iguana, .chameleon, .blueTonguedSkink:
            return .reptile
        }
    }

    // Grouped for picker display
    static var grouped: [(category: PetSpeciesCategory, species: [PetSpecies])] {
        [
            (.dogCat, [.canine, .feline]),
            (.smallMammal, [.rabbit, .ferret, .guineaPig, .hamster, .gerbil, .chinchilla, .rat, .mouse, .hedgehog, .sugarGlider]),
            (.bird, [.parakeet, .cockatiel, .parrot, .canary, .finch, .lovebird, .conure, .cockatoo, .macaw, .africanGrey]),
            (.reptile, [.beardedDragon, .leopardGecko, .ballPython, .cornSnake, .turtle, .tortoise, .iguana, .chameleon, .blueTonguedSkink])
        ]
    }
}

enum PetSpeciesCategory: String, CaseIterable {
    case dogCat = "Dogs & Cats"
    case smallMammal = "Small Mammals"
    case bird = "Birds"
    case reptile = "Reptiles"
}
