protocol CoreDataRepositoryType {
    func addFruit(_ name: String) throws
    func fetchFruits() throws -> [FruitEntity]
    func deleteFruit() throws
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
        return try dataSource.fetch()
    }
    
    func deleteFruit() throws {

    }
}
