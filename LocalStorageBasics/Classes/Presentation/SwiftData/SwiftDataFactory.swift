extension SwiftDataView {
    static func build() -> Self {
        SwiftDataView(
            viewModel: SwiftDataViewModel(
                repository: SwiftDataRepository(
                    dataSource: SwiftDataSource(types: [Expense.self])
                )
            )
        )
    }
}
