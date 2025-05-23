import SwiftUI

struct CoreDataView: View {
    @State var viewModel = CoreDataViewModel()
    @State var input = String()

    var body: some View {
        VStack(spacing: 20) {
            TextField("Add fruit here", text: $input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.headline)
                .cornerRadius(10)
            Button(action: {
                addValue()
            }, label: {
                Text("Add Value")
                    .frame(height: 32)
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(.borderedProminent)

            List {
                ForEach(viewModel.fruits) {
                    Text($0.name ?? "Empty name")
                }
                .onDelete(perform: viewModel.deleteFruit)
            }
            .listStyle(PlainListStyle())
        }
        .padding(.horizontal)
        .navigationTitle("Core Data")
    }

    private func addValue() {
        guard !input.isEmpty else { return }
        viewModel.addFruit(name: input)
        input = String()
    }
}

#Preview {
    CoreDataView()
}
