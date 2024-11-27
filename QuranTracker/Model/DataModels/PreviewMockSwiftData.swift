//
//  PreviewMockSwiftData.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 24.11.2024.
//

import Foundation
import SwiftData

@MainActor
class PreviewMockSwiftData {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: QuranReadingSession.self, configurations: config)

            for _ in 1..<6 {
                let readingSession = QuranReadingSession(
                    startPage: Int.random(in: 10..<20),
                    endPage: Int.random(in: 20..<30),
                    sessionDate: Date(
                        timeIntervalSince1970: Date.now.timeIntervalSince1970 + Double.random(in: 0...Date.weekInSeconds)
                    )
                )
                container.mainContext.insert(readingSession)
            }

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
