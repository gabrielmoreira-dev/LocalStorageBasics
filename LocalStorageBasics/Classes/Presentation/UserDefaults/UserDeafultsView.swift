import SwiftUI

struct UserDeafultsView: View {
    @State private var viewModel = UserDefaultsViewModel()
    @State private var input = String()

    var body: some View {
        VStack {
            Text(viewModel.value)
            Button("Get Value") { getValue() }
                .buttonStyle(.borderedProminent)
                .padding()

            Divider()
                .padding()

            TextField("Insert a value", text: $input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Set Value") { setValue() }
                .buttonStyle(.borderedProminent)
                .padding()

            Divider()
                .padding()

            Button("Delete Value") { deleteValue() }
                .buttonStyle(.borderedProminent)
                .padding()
        }
        .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
        .navigationTitle(Text("User Defaults"))
    }

    private func getValue() {
        Task {
            _ = await viewModel.getValue()
        }
    }

    private func setValue() {
        Task {
            _ = await viewModel.setValue(input)
        }
    }

    private func deleteValue() {
        Task {
            _ = await viewModel.deleteValue()
        }
    }
}

#Preview {
    UserDeafultsView()
}
