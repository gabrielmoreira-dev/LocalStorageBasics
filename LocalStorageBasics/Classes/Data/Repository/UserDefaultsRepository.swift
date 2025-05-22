protocol UserDefaultsRepositoryType {
    func setValue(_ value: String) async
    func getValue() async -> String?
    func deleteValue() async
}

final class UserDefaultsRepository {
    private let localDataSource: UserDefaultsDataSourceType
    private let key = "value"

    init(localDataSource: UserDefaultsDataSourceType = UserDefaultsDataSource()) {
        self.localDataSource = localDataSource
    }
}

extension UserDefaultsRepository: UserDefaultsRepositoryType {
    func setValue(_ value: String) async {
        await localDataSource.set(value, using: key)
    }

    func getValue() async -> String? {
        await localDataSource.get(using: key)
    }

    func deleteValue() async {
        await localDataSource.delete(using: key)
    }
}
