//
//  ContinuedLearning_AdvancedApp.swift
//  ContinuedLearning-Advanced
//
//  Created by Volkan Celik on 03/10/2023.
//

import SwiftUI

@main
struct ContinuedLearning_AdvancedApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
