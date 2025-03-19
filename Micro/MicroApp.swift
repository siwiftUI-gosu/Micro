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

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
