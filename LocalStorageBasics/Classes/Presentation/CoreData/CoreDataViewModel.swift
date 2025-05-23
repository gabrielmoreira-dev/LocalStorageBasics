import SwiftUI

@MainActor
@Observable
final class CoreDataViewModel {
    private let repository: CoreDataRepositoryType
    private(set) var fruits: [FruitEntity] = []

    init(repository: CoreDataRepositoryType = CoreDataRepository()) {
        self.repository = repository
    }

    func fetchFruits() {
        do {
            fruits = try repository.fetchFruits()
        } catch { }
    }

    func addFruit(name: String) {
        do {
            try repository.addFruit(name)
            fetchFruits()
        } catch { }
    }
}
