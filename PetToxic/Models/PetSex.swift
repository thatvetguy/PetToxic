import Foundation

enum PetSex: String, CaseIterable, Codable {
    case male
    case maleNeutered
    case female
    case femaleSpayed

    var displayName: String {
        switch self {
        case .male: return "Male"
        case .maleNeutered: return "Male (Neutered)"
        case .female: return "Female"
        case .femaleSpayed: return "Female (Spayed)"
        }
    }
}
