//
//  JournaliApp.swift
//  Journali
//
//  Created by Nouf on 20/10/2024.
//

import SwiftUI

@main
struct JournaliApp: App {
//    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainPage()/*.environment(\.managedObjectContext, persistenceController.container.viewContext)*/
//            ContentView()
        }
    }
}
