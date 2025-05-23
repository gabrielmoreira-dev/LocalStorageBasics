import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                UserDeafultsView()
            }
            .tabItem {
                Label("User Defaults", systemImage: "person.circle.fill")
            }
            NavigationView {
                CoreDataView()
            }
            .tabItem {
                Label("Core Data", systemImage: "tablecells")
            }
        }
    }
}

#Preview {
    ContentView()
}
