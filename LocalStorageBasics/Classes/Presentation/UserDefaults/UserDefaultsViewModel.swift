import SwiftUI

@MainActor
@Observable
final class UserDefaultsViewModel {
    private let repository: UserDefaultsRepositoryType
    private(set) var value = String()

    init(repository: UserDefaultsRepositoryType = UserDefaultsRepository()) {
        self.repository = repository
    }

    func getValue() async -> Bool {
        if let value = await repository.getValue() {
            self.value = value
            return true
        }
        self.value = String()
        return false
    }

    func setValue(_ value: String) async -> Bool {
        await repository.setValue(value)
        return true
    }

    func deleteValue() async -> Bool {
        await repository.deleteValue()
        return true
    }
}
