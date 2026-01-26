import Foundation
import SwiftData

@Model
final class Pet {
    var id: UUID
    var name: String
    var nickname: String?
    var species: String  // Store as raw value, convert to PetSpecies enum
    var breed: String?
    var sex: String  // Store as raw value, convert to PetSex enum
    var weightLbs: Double?
    var birthday: Date?
    var isBirthdayApproximate: Bool
    var photoFilename: String?
    var microchipNumber: String?
    var vetClinicName: String?
    var vetPhone: String?
    var notes: String?
    var dateCreated: Date
    var dateModified: Date
    var sortOrder: Int
    var prioritizeInBrowse: Bool = true

    @Relationship(deleteRule: .cascade, inverse: \PoisonControlCase.pet)
    var poisonControlCases: [PoisonControlCase] = []

    init(
        id: UUID = UUID(),
        name: String,
        nickname: String? = nil,
        species: PetSpecies = .canine,
        breed: String? = nil,
        sex: PetSex = .male,
        weightLbs: Double? = nil,
        birthday: Date? = nil,
        isBirthdayApproximate: Bool = false,
        photoFilename: String? = nil,
        microchipNumber: String? = nil,
        vetClinicName: String? = nil,
        vetPhone: String? = nil,
        notes: String? = nil,
        sortOrder: Int = 0,
        prioritizeInBrowse: Bool = true
    ) {
        self.id = id
        self.name = name
        self.nickname = nickname
        self.species = species.rawValue
        self.breed = breed
        self.sex = sex.rawValue
        self.weightLbs = weightLbs
        self.birthday = birthday
        self.isBirthdayApproximate = isBirthdayApproximate
        self.photoFilename = photoFilename
        self.microchipNumber = microchipNumber
        self.vetClinicName = vetClinicName
        self.vetPhone = vetPhone
        self.notes = notes
        self.dateCreated = Date()
        self.dateModified = Date()
        self.sortOrder = sortOrder
        self.prioritizeInBrowse = prioritizeInBrowse
    }

    // MARK: - Computed Properties

    var speciesEnum: PetSpecies {
        get { PetSpecies(rawValue: species) ?? .canine }
        set { species = newValue.rawValue }
    }

    var sexEnum: PetSex {
        get { PetSex(rawValue: sex) ?? .male }
        set { sex = newValue.rawValue }
    }

    var weightKg: Double? {
        guard let lbs = weightLbs else { return nil }
        return (lbs / 2.20462).rounded(toPlaces: 1)
    }

    var weightDisplayString: String {
        guard let lbs = weightLbs, let kg = weightKg else { return "--" }
        return "\(lbs.formatted(.number.precision(.fractionLength(1)))) lbs (\(kg.formatted(.number.precision(.fractionLength(1)))) kg)"
    }

    var age: (years: Int, months: Int)? {
        guard let birthday = birthday else { return nil }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: birthday, to: Date())
        guard let years = components.year, let months = components.month else { return nil }
        return (years, months)
    }

    var ageDisplayString: String {
        guard let age = age else { return "--" }
        if age.years == 0 {
            return "\(age.months) month\(age.months == 1 ? "" : "s")"
        } else if age.months == 0 {
            return "\(age.years) year\(age.years == 1 ? "" : "s")"
        } else {
            return "\(age.years) year\(age.years == 1 ? "" : "s"), \(age.months) month\(age.months == 1 ? "" : "s")"
        }
    }
}

// MARK: - Double Extension for Rounding

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
