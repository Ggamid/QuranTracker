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
    class ViewModel {

        var sessionDate: Date = .now
        var startPage: Int = 0
        var endPage: Int = 0
        var presentAlert = false
        var currentPage: Int?
        var currentSurah: String?

        func saveReadingSession(modelContext: ModelContext) -> Bool {
            if checkNumbers() {

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
            presentAlert = true
            return false
        }

        @MainActor
        func getSurahName(quranReadingSession: QuranReadingSession) async {
            currentPage = quranReadingSession.endPage
            do {
                guard let currentPage else { return }
                let quranPage = try await QuranData.fetchData(about: currentPage)
                let surah = quranPage.surahs.sorted { Int($0.key)! < Int($1.key)! } // сортируем массив по номеру сур
                // берем из массива первый элемент. там и будет содержаться название первой суры на странице Корана
                currentSurah = surah.first?.value.englishName
                return
            } catch {
                print("something went wrong")
                return
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
