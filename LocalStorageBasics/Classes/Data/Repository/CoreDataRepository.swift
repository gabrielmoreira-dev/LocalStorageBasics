protocol CoreDataRepositoryType {
    func addFruit(_ name: String) throws
    func fetchFruits() throws -> [FruitEntity]
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
        try dataSource.add(name)
    }
    
    func fetchFruits() throws -> [FruitEntity] {
        try dataSource.fetch()
    }
    
    func deleteFruit(_ fruit: FruitEntity) throws {
        try dataSource.delete(fruit)
    }
}
