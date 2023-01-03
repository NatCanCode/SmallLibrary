//
//  SmallLibraryApp.swift
//  SmallLibrary
//
//  Created by N N on 02/01/2023.
//

import SwiftUI

@main
struct SmallLibraryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
