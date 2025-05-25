import Foundation
import SwiftData

@Model
final class Expense {
    @Attribute(.unique) var id: UUID
    var name: String
    var date: Date
    var value: Double

    init(name: String, value: Double, id: UUID = UUID(), date: Date = .now) {
        self.id = id
        self.name = name
        self.date = date
        self.value = value
    }
}
