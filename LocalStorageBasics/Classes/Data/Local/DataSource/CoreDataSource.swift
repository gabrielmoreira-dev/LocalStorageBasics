import CoreData

protocol CoreDataSourceType {
    func add<T: NSManagedObject>(_ dataCompletion: (T) -> Void) throws
    func fetch<T: NSManagedObject>(_ clauses: [String: String]) throws -> [T]
    func delete<T: NSManagedObject>(_ entity: T) throws
}

final class CoreDataSource {
    private let container: NSPersistentContainer

    init(container: NSPersistentContainer) {
        self.container = container
        container.loadPersistentStores { description, error in
            if let error {
                debugPrint("[CoreDataSource] - Error loading Core Data: \(error)")
                return
            }
            debugPrint("[CoreDataSource] - Successfully loaded Core Data")
        }
    }

    convenience init(container: String) {
        self.init(container: NSPersistentContainer(name: container))
    }
}

extension CoreDataSource: CoreDataSourceType {
    func add<T: NSManagedObject>(_ dataCompletion: (T) -> Void) throws {
        let entity = T.init(context: container.viewContext)
        dataCompletion(entity)
        do {
            try container.viewContext.save()
            debugPrint("[CoreDataSource] - Add data")
        } catch {
            debugPrint("[CoreDataSource] - Error adding data: \(error)")
            throw error
        }
    }
    
    func fetch<T: NSManagedObject>(_ clauses: [String: String] = [:]) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        if !clauses.isEmpty {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: clauses.map({
                NSPredicate(format: $0, $1)
            }))
        }
        do {
            let result = try container.viewContext.fetch(request)
            debugPrint("[CoreDataSource] - Fetch data: \(result)")
            return result
        } catch {
            debugPrint("[CoreDataSource] - Error fetching data: \(error)")
            throw error
        }
    }
    
    func delete<T: NSManagedObject>(_ entity: T) throws {
        container.viewContext.delete(entity)
        do {
            try container.viewContext.save()
            debugPrint("[CoreDataSource] - Delete data: \(entity)")
        } catch {
            debugPrint("[CoreDataSource] - Error deleting data: \(error)")
            throw error
        }
    }
}
