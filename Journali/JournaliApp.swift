//
//  JournaliApp.swift
//  Journali
//
//  Created by Nouf on 20/10/2024.
//

import SwiftUI
import SwiftData

@main
struct JournaliApp: App {

    var body: some Scene {
        WindowGroup {
            MainPage()
                .modelContainer(for: Journal.self)

        }
    }
}
