//
//  CoreDataExampleApp.swift
//  Shared
//
//  Created by Steve Yu on 2020/11/14.
//

import SwiftUI

@main
struct CoreDataExampleApp: App {
    let persistenceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                             persistenceContainer.container.viewContext)
        }
    }
}
