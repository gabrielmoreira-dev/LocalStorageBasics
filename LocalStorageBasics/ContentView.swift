import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Hello")
                .tabItem {
                    Label("User Defaults", systemImage: "person.circle.fill")
                }
            Text("World")
                .tabItem {
                    Label("Core Data", systemImage: "tablecells")
                }
        }
    }
}

#Preview {
    ContentView()
}
