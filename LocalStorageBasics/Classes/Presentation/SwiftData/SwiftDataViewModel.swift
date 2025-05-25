import SwiftUI

@MainActor
@Observable
final class SwiftDataViewModel {
    private let repository: SwiftDataRepositoryType
    private(set) var expenses: [Expense] = []
    var nameInput = String()
    var valueInput: Double = 0.0
    var search = String()

    init(repository: SwiftDataRepositoryType) {
        self.repository = repository
        fetchExpenses()
    }

    func addExpense() {
        do {
            try repository.addExpense(name: nameInput, value: valueInput)
            fetchExpenses()
            nameInput = String()
            valueInput = 0.0
        } catch { }
    }

    func fetchExpenses() {
        do {
            expenses = try repository.fetchExpenses(matching: search)
        } catch { }
    }

    func deleteExpense(_ indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        do {
            try repository.deleteExpense(expenses[index])
            fetchExpenses()
        } catch {}
    }
}
