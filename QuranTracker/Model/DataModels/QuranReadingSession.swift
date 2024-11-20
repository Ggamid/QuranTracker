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

    var stringDate: String {
        getStringDate()
    }

    var weekDay: String {
        Date.getWeekDayInString(from: sessionDate.getWeekDayInInt())
    }

    init(startPage: Int, endPage: Int, sessionDate: Date) {
        self.startPage = startPage
        self.endPage = endPage
        self.sessionDate = sessionDate
    }

    private func getStringDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"

        return formatter.string(from: self.sessionDate)
    }
}

extension Date {
    func getWeekDayInInt() -> Int {
        Calendar.current.component(.weekday, from: self)
    }

    static func getWeekDayInString(from intWeekDay: Int) -> String {
        switch intWeekDay {
        case 7:
            "Сб"
        case 6:
            "Пт"
        case 5:
            "Чт"
        case 4:
            "Ср"
        case 3:
            "Вт"
        case 2:
            "Пн"
        case 1:
            "Вс"
        default:
            ""
        }
    }
}
