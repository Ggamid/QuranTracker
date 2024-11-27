//
//  Date+Extension.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 21.11.2024.
//

import Foundation

extension Date {
    func getWeekDayInInt() -> Int {
        let americanWeekDayNum = Calendar.current.component(.weekday, from: self)
        switch americanWeekDayNum {
        case 1: return 7
        case 2: return 1
        case 3: return 2
        case 4: return 3
        case 5: return 4
        case 6: return 5
        case 7: return 6
        default: return 0
        }
    }

    static func getWeekDayInString(from intWeekDay: Int) -> String {
        switch intWeekDay {
        case 7:
            "Вс"
        case 6:
            "Сб"
        case 5:
            "Пт"
        case 4:
            "Чт"
        case 3:
            "Ср"
        case 2:
            "Вт"
        case 1:
            "Пн"
        default:
            ""
        }
    }
    static let hourInSeconds: Double = 60*60
    static let dayInSeconds: Double = hourInSeconds * 24
    static let weekInSeconds: Double = dayInSeconds * 7

    static func getStringDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"

        return formatter.string(from: date)
    }

    // Функция для получения даты начала недели
    static func startOfWeek(from date: Date) -> Date? {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
        return startOfWeek
    }

    // Функция для получения даты конца недели
    static func endOfWeek(from date: Date) -> Date? {
        guard let startOfWeek = startOfWeek(from: date) else { return nil }
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: 6, to: startOfWeek)
    }

    static func getStartAndEndOfWeek(from date: Date) -> String {
        guard let endOfWeek = endOfWeek(from: date) else { return " " }
        guard let startOfWeek = startOfWeek(from: date) else { return " " }
        return "\(getStringDate(date: startOfWeek)) - \(getStringDate(date: endOfWeek))"
    }
}
