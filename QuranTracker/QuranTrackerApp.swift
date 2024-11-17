//
//  QuranTrackerApp.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 10.11.2024.
//

import SwiftUI
import SwiftData

@main
struct QuranTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [QuranReadingSession.self])
    }
}
