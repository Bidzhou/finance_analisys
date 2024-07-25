//
//  finance_analisysApp.swift
//  finance_analisys
//
//  Created by Frederico del' Bidzho on 10.07.2024.
//

import SwiftUI

let screen = UIScreen.main.bounds

@main
struct finance_analisysApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
