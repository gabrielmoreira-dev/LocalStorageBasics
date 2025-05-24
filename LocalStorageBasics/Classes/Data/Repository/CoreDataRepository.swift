protocol CoreDataRepositoryType {
    func addFruit(_ name: String) throws
    func fetchFruits(matching name: String?) throws -> [FruitEntity]
    func deleteFruit(_ fruit: FruitEntity) throws
}

final class CoreDataRepository {
    private let dataSource: CoreDataSourceType

    init(dataSource: CoreDataSourceType = CoreDataSource(container: "FruitsContainer")) {
        self.dataSource = dataSource
    }
}

extension CoreDataRepository: CoreDataRepositoryType {
    func addFruit(_ name: String) throws {
        try dataSource.add() { (entity: FruitEntity) in
            entity.name = name
        }
    }
    
    func fetchFruits(matching name: String?) throws -> [FruitEntity] {
        let clauses: [String: String] = if let name, !name.isEmpty {
            ["name BEGINSWITH[c] %@": name]
        } else { [:] }
        return try dataSource.fetch(clauses)
    }
    
    func deleteFruit(_ fruit: FruitEntity) throws {
        try dataSource.delete(fruit)
    }
}
