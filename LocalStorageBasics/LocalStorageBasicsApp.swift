//
//  LocalStorageBasicsApp.swift
//  LocalStorageBasics
//
//  Created by Gabriel on 21/05/25.
//

import SwiftUI

@main
struct LocalStorageBasicsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
