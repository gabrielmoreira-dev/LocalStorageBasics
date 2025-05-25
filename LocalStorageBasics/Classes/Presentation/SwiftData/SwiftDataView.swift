import SwiftUI

struct SwiftDataView: View {
    @State private var viewModel: SwiftDataViewModel

    init(viewModel: SwiftDataViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 20) {
            NavigationView {
                List {
                    ForEach(viewModel.expenses) {
                        ExpenseCell(expense: $0)
                    }
                    .onDelete(perform: viewModel.deleteExpense)
                }
                .listStyle(PlainListStyle())
            }
            .searchable(text: $viewModel.search)
            .onChange(of: viewModel.search, viewModel.fetchExpenses)

            TextField("Add expense here", text: $viewModel.nameInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.headline)
                .cornerRadius(10)
            TextField("Value", value: $viewModel.valueInput, format: .currency(code: "USD"))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.headline)
                .cornerRadius(10)
            Button(action: viewModel.addExpense, label: {
                Text("Add Value")
                    .frame(height: 32)
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal)
        .navigationTitle("Swift Data")
    }
}

#Preview {
    SwiftDataView(
        viewModel: SwiftDataViewModel(
            repository: SwiftDataRepository(
                dataSource: SwiftDataSource(types: [Expense.self])
            )
        )
    )
}

struct ExpenseCell: View {
    let expense: Expense

    var body: some View {
        HStack {
            Text(expense.date, format: .dateTime.month(.abbreviated).day())
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "USD"))
        }
    }
}
