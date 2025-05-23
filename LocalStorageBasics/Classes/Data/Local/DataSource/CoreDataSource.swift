import CoreData

protocol CoreDataSourceType {
    func add(_ name: String) throws
    func fetch() throws -> [FruitEntity]
    func delete(_ entity: FruitEntity) throws
}

final class CoreDataSource {
    private let container: NSPersistentContainer

    init(container: NSPersistentContainer) {
        self.container = container
        container.loadPersistentStores { description, error in
            if let error {
                debugPrint("[FruitCoreDataSource] - Error loading Core Data: \(error)")
                return
            }
            debugPrint("[FruitCoreDataSource] - Successfully loaded Core Data")
        }
    }

    convenience init(container: String) {
        self.init(container: NSPersistentContainer(name: container))
    }
}

extension CoreDataSource: CoreDataSourceType {
    func add(_ name: String) throws {
        let fruit = FruitEntity(context: container.viewContext)
        fruit.name = name
        do {
            try container.viewContext.save()
            debugPrint("[FruitCoreDataSource] - Add data")
        } catch {
            debugPrint("[FruitCoreDataSource] - Error adding data: \(error)")
            throw error
        }
    }
    
    func fetch() throws -> [FruitEntity] {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            let result = try container.viewContext.fetch(request)
            debugPrint("[FruitCoreDataSource] - Fetch data: \(result)")
            return result
        } catch {
            debugPrint("[FruitCoreDataSource] - Error fetching data: \(error)")
            throw error
        }
    }
    
    func delete(_ entity: FruitEntity) throws {
        container.viewContext.delete(entity)
        do {
            try container.viewContext.save()
            debugPrint("[FruitCoreDataSource] - Delete data: \(entity)")
        } catch {
            debugPrint("[FruitCoreDataSource] - Error deleting data: \(error)")
            throw error
        }
    }
}
