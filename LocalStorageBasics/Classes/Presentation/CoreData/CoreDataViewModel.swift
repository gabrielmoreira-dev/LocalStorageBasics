import SwiftUI

@MainActor
@Observable
final class CoreDataViewModel {
    private let repository: CoreDataRepositoryType
    private(set) var fruits: [FruitEntity] = []
    var input = String()
    var search = String()

    init(repository: CoreDataRepositoryType = CoreDataRepository()) {
        self.repository = repository
        fetchFruits()
    }

    func addFruit() {
        guard !input.isEmpty else { return }
        do {
            try repository.addFruit(input)
            fetchFruits()
            input = String()
        } catch { }
    }

    func fetchFruits() {
        do {
            fruits = try repository.fetchFruits(matching: search)
        } catch { }
    }

    func deleteFruit(_ indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let fruit = fruits[index]
        do {
            try repository.deleteFruit(fruit)
            fetchFruits()
        } catch { }
    }
}
