import Foundation
import SwiftData

protocol SwiftDataSourceType {
    func insert(_ model: any PersistentModel) throws
    func fetch<T: PersistentModel>(with predicate: Predicate<T>?) throws -> [T]?
    func delete(_ model: any PersistentModel)
}

final class SwiftDataSource {
    private let container: ModelContainer?
    private let context: ModelContext?

    @MainActor
    init(types: [any PersistentModel.Type], isStoredInMemoryOnly: Bool = false) {
        let schema = Schema(types)
        let configurations = ModelConfiguration(isStoredInMemoryOnly: isStoredInMemoryOnly)
        self.container = try? ModelContainer(for: schema, configurations: configurations)
        self.context = container?.mainContext
    }
}

extension SwiftDataSource: SwiftDataSourceType {
    func insert(_ model: any PersistentModel) throws {
        context?.insert(model)
        do {
            try context?.save()
            debugPrint("[SwiftDataSource] - Add data")
        } catch {
            debugPrint("[SwiftDataSource] - Error adding data: \(error)")
            throw error
        }
    }
    
    func fetch<T: PersistentModel>(with predicate: Predicate<T>?) throws -> [T]? {
        let request = FetchDescriptor<T>(predicate: predicate)
        do {
            let result = try context?.fetch(request)
            debugPrint("[SwiftDataSource] - Fetch data: \(result ?? [])")
            return result
        } catch {
            debugPrint("[SwiftDataSource] - Error fetching data: \(error)")
            throw error
        }
    }

    func delete(_ model: any PersistentModel) {
        context?.delete(model)
        debugPrint("[SwiftDataSource] - Delete data: \(model)")
    }
}
