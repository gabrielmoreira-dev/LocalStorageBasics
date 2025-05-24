import SwiftUI

struct CoreDataView: View {
    @State var viewModel = CoreDataViewModel()

    var body: some View {
        VStack(spacing: 20) {
            NavigationView {
                List {
                    ForEach(viewModel.fruits) {
                        Text($0.name ?? "Empty name")
                    }
                    .onDelete(perform: viewModel.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .searchable(text: $viewModel.search)
            .onChange(of: viewModel.search, viewModel.fetchFruits)

            TextField("Add fruit here", text: $viewModel.input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.headline)
                .cornerRadius(10)
            Button(action: viewModel.addFruit, label: {
                Text("Add Value")
                    .frame(height: 32)
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal)
        .navigationTitle("Core Data")
    }
}

#Preview {
    CoreDataView()
}
