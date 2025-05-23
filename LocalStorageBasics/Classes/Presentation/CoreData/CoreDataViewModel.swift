import SwiftUI

@MainActor
@Observable
final class CoreDataViewModel {
    private let repository: CoreDataRepositoryType
    private(set) var fruits: [FruitEntity] = []

    init(repository: CoreDataRepositoryType = CoreDataRepository()) {
        self.repository = repository
        fetchFruits()
    }

    func addFruit(name: String) {
        do {
            try repository.addFruit(name)
            fetchFruits()
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

    private func fetchFruits() {
        do {
            fruits = try repository.fetchFruits()
        } catch { }
    }
}
