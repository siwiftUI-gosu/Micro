//
//  MicroApp.swift
//  Micro
//
//  Created by pinocchio22 on 2/19/25.
//

import SwiftUI

@main
struct MicroApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
