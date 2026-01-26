import Foundation
import SwiftData

@Model
final class PoisonControlCase {
    var id: UUID
    var caseNumber: String
    var dateAdded: Date
    var note: String?
    var pet: Pet?

    init(
        id: UUID = UUID(),
        caseNumber: String,
        dateAdded: Date = Date(),
        note: String? = nil,
        pet: Pet? = nil
    ) {
        self.id = id
        self.caseNumber = caseNumber
        self.dateAdded = dateAdded
        self.note = note
        self.pet = pet
    }
}
