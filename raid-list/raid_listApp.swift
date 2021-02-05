//
//  raid_listApp.swift
//  raid-list
//
//  Created by Noice Dious on 05/02/2021.
//

import SwiftUI

@main
struct raid_listApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
