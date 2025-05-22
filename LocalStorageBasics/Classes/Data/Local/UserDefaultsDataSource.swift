import Foundation

protocol UserDefaultsDataSourceType {
    func set(_ value: Any?, using key: String) async
    func get<T>(using key: String) async -> T?
    func delete(using key: String) async
}

final class UserDefaultsDataSource {
    private let provider: UserDefaults

    init(provider: UserDefaults = .standard) {
        self.provider = provider
    }
}

extension UserDefaultsDataSource: UserDefaultsDataSourceType {
    func set(_ value: Any?, using key: String) {
        provider.set(value, forKey: key)
        debugPrint("[UserDefaultsDataSource] - Set value \(String(describing: value)) for key \(key)")
    }

    func get<T>(using key: String) -> T? {
        let value = provider.object(forKey: key) as? T
        debugPrint("[UserDefaultsDataSource] - Get value \(String(describing: value)) for key \(key)")
        return value
    }

    func delete(using key: String) {
        provider.removeObject(forKey: key)
        debugPrint("[UserDefaultsDataSource] - Remove value for key \(key)")
    }
}
