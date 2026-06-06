//
//  coreDataParthOneApp.swift
//  coreDataParthOne
//
//  Created by Максим Минаков on 06.06.2026.
//

import SwiftUI
import CoreData

@main
struct coreDataParthOneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
