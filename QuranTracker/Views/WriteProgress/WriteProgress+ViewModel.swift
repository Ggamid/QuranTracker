//
//  WriteProgress-ViewModel.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 17.11.2024.
//

import Foundation
import SwiftData
import SwiftUI

extension WriteProgressView {
    @Observable
    final class ViewModel {

        var sessionDate: Date = .now
        var startPage: Int = 0
        var endPage: Int = 0
        var presentAlert = false
        var currentPage: Int?
        var currentSurah: String?

        func saveReadingSession(modelContext: ModelContext) -> Bool {
            guard checkNumbers() else {
                presentAlert = true
                return false
            }

            let readingSession = QuranReadingSession(
                startPage: self.startPage,
                endPage: self.endPage,
                sessionDate: self.sessionDate
            )
            modelContext.insert(readingSession)

            startPage = 0
            endPage = 0
            return true
        }

        @MainActor
        func getSurahName(quranReadingSession: QuranReadingSession) async {
            currentPage = quranReadingSession.endPage
            do {
                guard let currentPage else { return }
                let quranPage = try await QuranData.fetchData(about: currentPage)
                // сортируем массив по номеру сур keys = "1", "2" etc
                let surah = quranPage.surahs.sorted {
                    guard let firstKey = Int($0.key), let secondKey = Int($1.key) else { return false }
                        return firstKey < secondKey
                }
                // берем из массива первый элемент. там и будет содержаться название первой суры на странице Корана
                currentSurah = surah.first?.value.englishName
                return

            } catch let error {
                print(#function, "\(error)")
                return
            }
        }

        private func checkNumbers() -> Bool {
            startPage < endPage
                    && (1...605).contains(startPage)
                    && (1...605).contains(endPage)
        }
    }
}
