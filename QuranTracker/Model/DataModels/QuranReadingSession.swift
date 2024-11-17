//
//  QuranReadingSession.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 17.11.2024.
//

import Foundation
import SwiftData

@Model
class QuranReadingSession {
    let startPage: Int
    let endPage: Int
    let sessionDate: Date

    var pageAmount: Int {
        endPage - startPage
    }

    init(startPage: Int, endPage: Int, sessionDate: Date) {
        self.startPage = startPage
        self.endPage = endPage
        self.sessionDate = sessionDate
    }

    func getStringDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"

        return formatter.string(from: self.sessionDate)
    }
}
