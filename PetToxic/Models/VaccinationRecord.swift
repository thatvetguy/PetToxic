import Foundation
import SwiftData

@Model
final class VaccinationRecord {
    var id: UUID
    var vaccineName: String
    var dateAdministered: Date
    var nextDueDate: Date?
    var notes: String?
    var pet: Pet?

    init(
        id: UUID = UUID(),
        vaccineName: String,
        dateAdministered: Date = Date(),
        nextDueDate: Date? = nil,
        notes: String? = nil,
        pet: Pet? = nil
    ) {
        self.id = id
        self.vaccineName = vaccineName
        self.dateAdministered = dateAdministered
        self.nextDueDate = nextDueDate
        self.notes = notes
        self.pet = pet
    }
}
