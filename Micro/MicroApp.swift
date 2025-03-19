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

        setUpReadMeBook()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    
    func setUpReadMeBook() {
        if CoreDataRepository.shared.fetchBookList().isEmpty {
            /// ReadMe Book init
            let _ = CoreDataRepository.shared.createNewBook(
                title: "ReadMe",
                isWrite: false,
                createDate: nil,
                goalList: [],
                iD: .init(),
                isGuide: true
            )
            
            /// Write Book init
            let _ = CoreDataRepository.shared.createNewBook(
                title: "작성 중",
                isWrite: true,
                createDate: Date.now,
                goalList: [],
                iD: .init(),
                isGuide: false
            )
        }
    }
}
