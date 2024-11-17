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
        var presentAlert = false

        func saveReadingSession(modelContext: ModelContext) -> Bool {
            if checkNumbers() {
                DispatchQueue.global().async {
                    let readingSession = QuranReadingSession(
                        startPage: self.startPage,
                        endPage: self.endPage,
                        sessionDate: self.sessionDate
                    )
                    modelContext.insert(readingSession)
                }
                startPage = 0
                endPage = 0
                return true
            }
            presentAlert = true
            return false
        }

        func checkNumbers() -> Bool {
            startPage < endPage
                    && (0...605).contains(startPage)
                    && (0...605).contains(endPage)
                    && endPage != 0
        }
    }
}
