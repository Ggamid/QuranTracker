//
//  WriteProgress-ViewModel.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 17.11.2024.
//

import Foundation
import SwiftData

extension WriteProgressView {
    @Observable
    class ViewModel {

        var sessionDate: Date = .now
        var startPage: Int = 0
        var endPage: Int = 0

        func saveReadingSession(modelContext: ModelContext) {
            DispatchQueue.global().async {
                let readingSession = QuranReadingSession(
                    startPage: self.startPage,
                    endPage: self.endPage,
                    sessionDate: self.sessionDate
                )
                modelContext.insert(readingSession)
            }
        }

        func checkNumbers() -> Bool {
            startPage < endPage
                    && (0...605).contains(startPage)
                    && (0...605).contains(endPage)
                    && endPage != 0
        }
    }
}
