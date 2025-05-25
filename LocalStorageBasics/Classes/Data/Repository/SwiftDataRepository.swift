import Foundation

protocol SwiftDataRepositoryType {
    func addExpense(name: String, value: Double) throws
    func fetchExpenses(matching name: String) throws -> [Expense]
    func deleteExpense(_ expense: Expense) throws
}

final class SwiftDataRepository {
    private let dataSource: SwiftDataSourceType

    init(dataSource: SwiftDataSourceType) {
        self.dataSource = dataSource
    }
}

extension SwiftDataRepository: SwiftDataRepositoryType {
    func addExpense(name: String, value: Double) throws {
        let expense = Expense(name: name, value: value)
        try dataSource.insert(expense)
    }

    func fetchExpenses(matching name: String) throws -> [Expense] {
        let predicate = name.isEmpty ? nil : #Predicate<Expense> {
            $0.name.starts(with: name)
        }
        return try dataSource.fetch(with: predicate) ?? []
    }

    func deleteExpense(_ expense: Expense) throws {
        dataSource.delete(expense)
    }
}
